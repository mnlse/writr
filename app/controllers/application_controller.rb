class ApplicationController < ActionController::Base
  before_action :configure_devise_params, if: :devise_controller?

  before_action :define_full_name, if: :user_signed_in?
  before_action :define_categories

  protected
  def define_categories
    @categories = Category.all
  end

  def define_full_name
    @full_name = current_user.first_name + " " + current_user.last_name
  end

  def configure_devise_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name, :country_id])
  end
end
