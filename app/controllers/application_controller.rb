# frozen_string_literal: true

class ApplicationController < ActionController::Base
  # before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  layout :layout_by_resource

  private

  def after_sign_in_path_for(_resource)
    user_path(current_user)
  end

  def after_sign_out_path_for(_resource)
    root_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email])
  end

  def layout_by_resource
    if devise_controller?
      false
    else
      'application'
    end
  end
end
