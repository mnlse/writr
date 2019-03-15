class RegistrationsController < Devise::RegistrationsController
  def new
    super
    @country_list = Country.all.map { |hash| [hash.name, hash.id] }
  end

  def create
    super
  end
end
