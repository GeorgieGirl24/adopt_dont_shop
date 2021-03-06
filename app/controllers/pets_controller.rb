class PetsController < ApplicationController
  def index
    @pets = Pet.all
  end

  def index_shelter
    @shelter = Shelter.find(params[:shelter_id])
    @pets = @shelter.pets.all
  end

  def show
    @pet = Pet.find(params[:id])
  end

  def new
    @shelter = Shelter.find(params[:shelter_id])
  end

  def create
    pet = Pet.new(pet_params)
    pet.save
    redirect_to "/shelters/#{pet.shelter_id}/pets"
  end

  def edit
    @pet = Pet.find(params[:pet_id])
  end

  def update
    edit.update(pet_params)
    redirect_to "/pets/#{@pet.id}"
  end

  def destroy
    @pet = Pet.find(params[:pet_id])
    @pet.destroy
    redirect_to "/shelters/#{@pet.shelter_id}/pets"
  end

  private
  def pet_params
    params.permit(:image, :name, :description, :approximate_age, :sex, :shelter_id)
  end
end
