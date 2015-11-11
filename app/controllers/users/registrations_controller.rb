class Users::RegistrationsController < ActiveAdmin::Devise::RegistrationsController
  before_filter :configure_permitted_parameters

  def create
    super do |resource|
      resource.update_attribute :fake, false if resource.valid?
    end
  end

  protected

  def configure_permitted_parameters
    [:sign_up, :account_update].each do |method|
      devise_parameter_sanitizer.for(method) do |u|
        u.permit(:email, :password, :password_confirmation, :uuid)
      end
    end
  end
end
