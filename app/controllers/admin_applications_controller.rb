class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @application_pets = ApplicationPet.where(application_id: params[:application_id])
    # binding.pry
  end

  def update
    @application = Application.find(params[:application_id])
    @application_pet = ApplicationPet.find(params[:pet_id])

    @application_pets = ApplicationPet.where(application_id: params[:application_id])

    # if @application_pet.pet.adoptable == false
    # @application_pets.find(params).find_pet
      # ApplicationPet.find_pet
# binding.pry
  end


    # we need the pet_id from application_pets so we can use pet.adoptable
    # we need to change @application_pets.pet_status to accepted or rejected
    #
    # which then makes us need to change @application status to accepted or rejected



  private
  def application_params
    params.require(:application).permit(:pet_status, :pet_id, :application_id)
  end

end
