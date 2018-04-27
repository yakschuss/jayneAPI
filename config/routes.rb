Rails.application.routes.draw do
  get "uptime", to: "jayne#uptime"

  namespace :pug_bot do
  end
end
