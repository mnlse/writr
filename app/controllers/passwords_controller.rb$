class PasswordsController < Devise::PasswordsController
  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.valid_password?(params[:user][:password])
      if params[:user][:new_password] == params[:user][:confirm_new_password]
        @user.password = params[:user][:new_password]
        @user.save
        puts ("*" * 30)
        puts "New password is #{params[:user][:new_password]}"
        puts ("*" * 30)
        redirect_to new_user_session_url, notice: "You have successfully changed the password."
      else
        redirect_back fallback_location: edit_user_password_path, alert: "New passwords do not match"
      end
    else
      redirect_back fallback_location: edit_user_password_path, alert: "Current password is wrong."
    end
  end
end
