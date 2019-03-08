class RegistrationsController < Devise::RegistrationsController
  def new
    super
    @country_list = Country.all.map { |hash| [hash.name, hash.id] }
  end

  def create
    super
  end

  private
  def permitted_params
    params.require(:user).permit(:first_name, :last_name, :email, :country_id, :password, :password_confirmation)
  end
end
