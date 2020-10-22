class SheltersController < ApplicationController
  def index
    @shelters = Shelter.all
  end

  def new
  end

  def show
    @shelter = Shelter.find(params[:id])
  end

  def create
    shelter = Shelter.new(shelter_params)
    shelter.save
    redirect_to '/shelters'
  end

  def edit
    @shelter = Shelter.find(params[:id])
  end

  def update
    edit.update(shelter_params)
    redirect_to '/shelters'
  end

  def destroy
    @shelter = Shelter.find(params[:id])
    @shelter.destroy
    redirect_to '/shelters'
  end

  private
  def shelter_params
    params.permit(:name, :address, :city, :state, :zip)
  end
end
