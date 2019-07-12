class CreditCardsController < ApplicationController
  before_action :find_credit_card, only: [:update, :destroy]
  def update

    if @cc.update(permitted_params)
      flash[:notice] = "You have successfully updated your credit card information"
    else
      flash[:alert] = "There has been a problem updating your credit card information"
    end

    redirect_back fallback_location: pages_settings_credentials_url
  end

  def create
    @cc = CreditCard.new(permitted_params)
    @cc.user = current_user

    if @cc.save
      flash[:notice] = "You have successfully updated your credit card information"
    else
      flash[:alert] = "There has been a problem updating your credit card information"
    end

    redirect_back fallback_location: pages_settings_credentials_url
  end

  def destroy
    if @cc.destroy
      flash[:notice] = "Successfully deleted credit card"
    else
      flash[:alert] = "There was an error while deleting your credit card."
    end
    redirect_back fallback_location: pages_settings_credentials_url
  end

  private
  def permitted_params
    params.require(:credit_card).permit(:cvv, :holder_name, :expiry_month, :expiry_year, :number)
  end

  def find_credit_card
    @cc = CreditCard.find(params[:id])
  end
end
