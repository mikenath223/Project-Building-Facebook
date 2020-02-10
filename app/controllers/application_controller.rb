# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :authenticate_user!

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:account_update) do |u|
        u.permit(:nickname, :location, :gender, :age)
    end
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[nickname gender location age])
  end
end
