class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @application_pets = ApplicationPet.where(application_id: params[:application_id])
  end

  def update
    @application = Application.find(params[:application_id])
    @application_pet = ApplicationPet.find(params[:pet_id])
    @application_pet.pet_status == 'Accepted'
    @application_pet.pet.update(adoptable: false)
    
    redirect_to "/admin/applications/#{@application.id}"
  end
end

# if @application_pet.pet_status == nil
#   @application_pet.pet_status == 'Accepted'
#   if
#     @application_pet.update(pet_status: 'Accepted')
#     @application_pet.pet.update(adoptable: false)
#   elsif @application_pet.pet_status == 'Rejected'
#     @application_pet.update(pet_status: 'Rejected')
#   end
# end
