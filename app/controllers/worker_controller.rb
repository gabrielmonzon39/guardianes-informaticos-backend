class WorkerController < ApplicationController
  # receives client_id and monday date
  def confirm_schedules
    client = Client::Client.find(params[:client_id])
    monday_date = Date.parse(params[:monday_date])
    return render json: { error: 'Client not found' }, status: :not_found unless client

    workers = client.workers
    client_schedules = client.schedules

    total_hours = 0
    @total_taken_hours = {}
    @total_available_hours = {}
    @taken_by_day = {}
    @available_by_day = {}

    @worker_schedules_hash = {}
    @confirmed_schedule = {}

    workers.each do |worker|
      @total_taken_hours[worker.id] = 0
      @total_available_hours[worker.id] = 0
      @taken_by_day[worker.id] = {}
      @available_by_day[worker.id] = {}
    end

    # hash to store the previous worker schedule for each day of the week
    previous_worker_schedule = {}

    max_iterations = 0
    # group by day and hour
    client_schedules.each do |schedule|
      total_hours += schedule.end - schedule.start

      # initialize @confirmed_schedule hash with {} for each day of the week
      @confirmed_schedule[schedule.day_of_week] = {}

      # select worker schedules for the day of the week
      worker_schedules = Worker::Schedule.where(worker: workers).select do |ws|
        ws.day_of_week == schedule.day_of_week && ws.time >= monday_date && ws.time < monday_date + 7.days
      end

      # update all worker schedules to be unconfirmed and add to total_available_hours and available_by_day
      worker_schedules.each do |ws|
        ws.update(confirmed: false)
        @total_available_hours[ws.worker_workers_id] += 1

        if @available_by_day[ws.worker_workers_id][ws.day_of_week]
          @available_by_day[ws.worker_workers_id][ws.day_of_week] += 1
        else
          @available_by_day[ws.worker_workers_id][ws.day_of_week] = 1
        end

        @taken_by_day[ws.worker_workers_id][ws.day_of_week] = 0
      end

      day_of_week_hash = {}

      # group by hour
      for i in schedule.start..(schedule.end - 1) do
        @confirmed_schedule[schedule.day_of_week][i] = 0

        day_of_week_hash[i] = worker_schedules.select { |ws| ws.hour == i }

        # set max iterations to the number of worker schedules in the day of the week if it is greater than the current max iterations
        max_iterations = day_of_week_hash[i].count if day_of_week_hash[i].count > max_iterations
      end

      @worker_schedules_hash[schedule.day_of_week] = day_of_week_hash

      # store the previous worker schedule for each day of the week
      previous_worker_schedule[schedule.day_of_week] = nil
    end

    @hours_per_worker = total_hours / workers.count
    @total_hours = total_hours
    @workers_count = workers.count

    # assign schedules to workers
    @iteration = 1
    while @iteration <= max_iterations
      assign_schedule
      @iteration += 1
    end
  end

  # receives worker_id, time and value
  def toggle_schedule
    time = DateTime.parse(params[:time])
    value = params[:value]

    worker_schedule = Worker::Schedule.find_by(worker_workers_id: params[:worker_id], time: time)
    worker_schedule.destroy unless value

    Worker::Schedule.create(worker_workers_id: params[:worker_id], time: time) if value
  end

  private

  # error por que al cambiar de iteracion se cambia el ultimo asignado

  def assign_schedule
    # iterate over each day of the week
    @worker_schedules_hash.each do |day_of_week, day_of_week_hash|
      # iterate over each hour of the day
      day_of_week_hash.each do |hour, worker_schedules|
        ws_count = worker_schedules.count
        next if ws_count != @iteration || ws_count == 0

        if ws_count == 1
          worker_schedule = worker_schedules.first
          worker_schedule.update(confirmed: true)
          @total_taken_hours[worker_schedule.worker_workers_id] += 1
          @taken_by_day[worker_schedule.worker_workers_id][day_of_week] += 1
          @total_available_hours[worker_schedule.worker_workers_id] -= 1
          @available_by_day[worker_schedule.worker_workers_id][day_of_week] -= 1
          next
        end

        # get total_taken_hours total_available_hours taken_by_day available_by_day for the worker_schedules worker in a hash

        total_taken_hours = {}
        total_available_hours = {}
        taken_by_day = {}
        available_by_day = {}

        final_decision = {}

        worker_schedules.each do |ws|
          total_taken_hours[ws.worker_workers_id] = @total_taken_hours[ws.worker_workers_id]
          total_available_hours[ws.worker_workers_id] = @total_available_hours[ws.worker_workers_id]
          taken_by_day[ws.worker_workers_id] = @taken_by_day[ws.worker_workers_id][ws.day_of_week]
          available_by_day[ws.worker_workers_id] = @available_by_day[ws.worker_workers_id][ws.day_of_week]
          final_decision[ws.worker_workers_id] = 0

          # check adjacent hours in confirmed schedules and add to final decision if same worker
          if @confirmed_schedule[day_of_week][hour - 1] == ws.worker_workers_id
            final_decision[ws.worker_workers_id] += 3
          end

          if @confirmed_schedule[day_of_week][hour + 1] == ws.worker_workers_id
            final_decision[ws.worker_workers_id] += 3
          end
        end

        sort_workers(total_taken_hours).each_with_index do |worker_id, index|
          final_decision[worker_id] -= (1 - (1 / (ws_count - 1)) * index) * 5
        end
        # sort_workers(total_available_hours).each_with_index do |worker_id, index|
        #   final_decision[worker_id] += 1 - (1 / (ws_count - 1)) * index
        # end
        # sort_workers(taken_by_day).each_with_index do |worker_id, index|
        #   final_decision[worker_id] += 1 - (1 / (ws_count - 1)) * index
        # end
        # sort_workers(available_by_day).each_with_index do |worker_id, index|
        #   final_decision[worker_id] += 1 - (1 / (ws_count - 1)) * index
        # end

        worker_id_with_max_decision = sort_workers(final_decision).first
        # assign the worker schedule to the worker with the highest decision
        worker_schedules.each do |ws|
          ws.update(confirmed: true) if ws.worker_workers_id == worker_id_with_max_decision
        end

        worker_id_with_max_decision = sort_workers(total_taken_hours).last if worker_id_with_max_decision.nil?

        @confirmed_schedule[day_of_week][hour] = worker_id_with_max_decision

        @total_taken_hours[worker_id_with_max_decision] += 1
        @taken_by_day[worker_id_with_max_decision][day_of_week] += 1
        @total_available_hours[worker_id_with_max_decision] -= 1
        @available_by_day[worker_id_with_max_decision][day_of_week] -= 1
      end
    end
  end

  # receive hash with worker_id as key and a number as value and return array with the worker_ids in order of the biggest to lowest value
  def sort_workers(hash)
    hash.sort_by { |_key, value| value }.reverse.map { |key, _value| key }
  end
end
