Rails.application.routes.draw do

  devise_config = ActiveAdmin::Devise.config
  devise_config[:controllers][:registrations] = "users/registrations"
  devise_for :users, devise_config
  ActiveAdmin.routes(self)

  get "charts" => "charts#index", defaults: { format: 'json' }, as: :charts
end
