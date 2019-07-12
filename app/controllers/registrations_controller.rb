class RegistrationsController < Devise::RegistrationsController
  # prepend_before_action :require_no_authentication, :only => [ :edit, :update]

  def new
    super
    @country_list = Country.all.map { |hash| [hash.name, hash.id] }
  end

  def create
    super
  end

  def update
    puts "*" * 30

    if params[:password]&.empty?
      resource.update(pwd_params)
    else
      resource.update_without_password(no_pwd_params)
    end

    redirect_back fallback_location: root_path
  end

  private
  def no_pwd_params
    params.require(:user).permit(:bio, :avatar, :profile_background)
  end

  def pwd_params
    params.require(:user).permit(:bio, :avatar, :profile_background, :password, :password_confirmation)
  end
end
