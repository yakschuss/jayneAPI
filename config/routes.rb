Rails.application.routes.draw do
  get "uptime", to: "jayne#uptime"
  get "wakeup", to: "jayne#wakeup"

  namespace :pug_bot do
  end
end
