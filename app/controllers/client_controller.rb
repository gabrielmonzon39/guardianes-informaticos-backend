class ClientController < ApplicationController
  before_action :set_client, only: %i[weeks schedule schedule_edit]
  before_action :set_translations
  def index
    @clients = Client::Client.all
    return render json: { error: 'No clients found' }, status: :not_found unless @clients.any?

    render json: @clients.map { |client| { label: client.name, value: client.id } }
  end

  def weeks
    earliest_date = Time.now.beginning_of_week
    @client.workers.each do |worker|
      worker.schedules.each do |schedule|
        earliest_date = schedule.time if earliest_date.nil? || schedule.time < earliest_date
      end
    end

    # get start date of week from earliest date
    start_date = earliest_date.beginning_of_week

    # get latest date of week 5 weeks from now
    latest_date = Time.now.beginning_of_week + 5.weeks

    # get all weeks between start and latest date
    @weeks = []
    while start_date < latest_date
      @weeks.push(start_date)
      start_date += 1.week
    end

    render json: @weeks.each_with_index.map { |week, index|
      { label: "Semana #{index + 1} -> #{week.strftime('%Y-%m-%d')}", value: week.strftime('%Y-%m-%d'),
        from: week.strftime('%Y-%m-%d'), to: (week + 6.days).strftime('%Y-%m-%d') }
    }
  end

  def schedule
    @monday_date = params[:monday_date].to_date
    @workers = @client.workers
    schedules = {}

    # hash to know each worker number of working hours
    hours_by_worker = {}
    worker_colors = {}
    @workers.each do |worker|
      hours_by_worker[worker.name] = 0
      worker_colors[worker.name] = worker.color
    end
    worker_colors['Sin Asignar'] = 'black'
    hours_by_worker['Sin Asignar'] = 0

    @client.schedules.each do |schedule|
      # make hash for each hour from start to end and set worker if worker has confirmed schedule
      day_schedule = []
      for i in schedule.start..(schedule.end - 1) do
        time = @monday_date + i.hours + @day_of_week_day_offset[schedule.day_of_week].days
        worker_name = search_confirmed_schedule(time)
        hours_by_worker[worker_name] += 1
        # day_schedule[i] = {
        #   worker: worker_name,
        #   time: "#{time.strftime('%H:%M')} - #{(time + 1.hour).strftime('%H:%M')}",
        # }
        day_schedule.push({
                            worker: worker_name,
                            time: "#{time.strftime('%H:%M')} - #{(time + 1.hour).strftime('%H:%M')}"
                          })
      end

      # translate day of week to spanish
      day_of_week = @day_of_week_translations[schedule.day_of_week]
      time_with_offset = (@monday_date + @day_of_week_day_offset[schedule.day_of_week])
      schedules[schedule.day_of_week] = {
        day_of_week: day_of_week,
        date: "#{day_of_week} #{time_with_offset.strftime('%d')} de #{@month_of_year_translations[time_with_offset.strftime('%B')]}",
        start: schedule.start,
        end: schedule.end,
        day_schedule: day_schedule
      }
    end

    final_hours_by_worker = []

    hours_by_worker.each do |worker_name, hours|
      final_hours_by_worker.push({
                                   hours: hours,
                                   name: worker_name,
                                   color: worker_colors[worker_name]
                                 })
    end

    render json: { schedules: schedules, hours_by_worker: final_hours_by_worker, worker_colors: worker_colors }
  end

  def schedule_edit
    @monday_date = params[:monday_date].to_date
    @workers = @client.workers
    schedules = {}

    # hash to know each worker number of working hours
    worker_colors = {}
    @workers.each do |worker|
      worker_colors[worker.name] = worker.color
    end

    @client.schedules.each do |schedule|
      # make hash for each hour from start to end and set worker if worker has confirmed schedule
      day_schedule = []
      for i in schedule.start..(schedule.end - 1) do
        time = @monday_date + i.hours + @day_of_week_day_offset[schedule.day_of_week].days
        workers = seach_all_schedule(time)
        # day_schedule[i] = {
        #   worker: worker_name,
        #   time: "#{time.strftime('%H:%M')} - #{(time + 1.hour).strftime('%H:%M')}",
        # }
        day_schedule.push(
          {
            workers: workers,
            time: "#{time.strftime('%H:%M')} - #{(time + 1.hour).strftime('%H:%M')}",
            api_time: time
          }
        )
      end

      # translate day of week to spanish
      day_of_week = @day_of_week_translations[schedule.day_of_week]
      time_with_offset = (@monday_date + @day_of_week_day_offset[schedule.day_of_week])
      schedules[schedule.day_of_week] = {
        day_of_week: day_of_week,
        date: "#{day_of_week} #{time_with_offset.strftime('%d')} de #{@month_of_year_translations[time_with_offset.strftime('%B')]}",
        start: schedule.start,
        end: schedule.end,
        day_schedule: day_schedule
      }
    end

    render json: { schedules: schedules, worker_colors: worker_colors }
  end

  private

  def set_client
    @client = Client::Client.find(params[:id])
    return render json: { error: 'No client found' }, status: :not_found unless @client
  end

  def search_confirmed_schedule(time)
    worker_schedule = Worker::Schedule.find_by(worker: @workers, time: time, confirmed: true)
    return 'Sin Asignar' unless worker_schedule

    worker_schedule.worker.name
  end

  def seach_all_schedule(time)
    worker_schedules = Worker::Schedule.where(worker: @workers, time: time)

    workers_has_schedule = {}
    @workers.each do |worker|
      workers_has_schedule[worker.name] = {
        has_schedule: worker_schedules.find_by(worker: worker, time: time) ? true : false,
        worker_id: worker.id
      }
    end
    workers_has_schedule
  end

  def set_translations
    # hash for day of week translations to spanish
    @day_of_week_translations = {
      'monday' => 'Lunes',
      'tuesday' => 'Martes',
      'wednesday' => 'Miercoles',
      'thursday' => 'Jueves',
      'friday' => 'Viernes',
      'saturday' => 'Sabado',
      'sunday' => 'Domingo'
    }

    @month_of_year_translations = {
      'January' => 'Enero',
      'February' => 'Febrero',
      'March' => 'Marzo',
      'April' => 'Abril',
      'May' => 'Mayo',
      'June' => 'Junio',
      'July' => 'Julio',
      'August' => 'Agosto',
      'September' => 'Septiembre',
      'October' => 'Octubre',
      'November' => 'Noviembre',
      'December' => 'Diciembre'
    }

    @day_of_week_day_offset = {
      'monday' => 0,
      'tuesday' => 1,
      'wednesday' => 2,
      'thursday' => 3,
      'friday' => 4,
      'saturday' => 5,
      'sunday' => 6
    }
  end
end
