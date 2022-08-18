Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post '/confirm_schedules', to: 'worker#confirm_schedules'

  get '/clients', to: 'client#index'
  get '/clients/:id/weeks', to: 'client#weeks'
  get '/clients/:id/weeks/:monday_date', to: 'client#schedule'
  get '/clients/:id/weeks/:monday_date/edit', to: 'client#schedule_edit'

  post '/workers/toggle-schedule', to: 'worker#toggle_schedule'
end
