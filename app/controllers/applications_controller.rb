class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @user = User.find(@application.user_id)
    # binding.pry
    @pets = Pet.search(params[:search])

#   @pets = Pet.where('lower(name) = ?', "%#{@pet.name.downcase}%")
# Pet.where('lower(name) = ?', pet.name.downcase)
  end

  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    if !@user.nil?
      @application = @user.applications.new(application_params)
      @application.save
      redirect_to "/applications/#{@application.id}"
    else
      flash.now[:alert] = 'Invalid user, must be a valid user.'
      render :new
    end
  end

  def update
    @application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    @application.add_pet(pet)
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:description, :status)
  end

  def pet_params
    params.require(:pet).permit(:name, :approximate_age, :image, :description, :sex, :search)
  end
end
