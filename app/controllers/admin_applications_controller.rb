class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @application_pets = ApplicationPet.where(application_id: params[:application_id])
  end

  def update
    @application = Application.find(params[:application_id])
    @application_pet = ApplicationPet.find(params[:pet_id])
    @application_pet.update(pet_status: 'Accepted')
    redirect_to "/admin/applications/#{@application.id}"
  end
end
