class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @user = User.find(@application.user_id)
    if params[:search]
      @pets = Pet.where('lower(name) LIKE ?', "%#{params[:search]}%".downcase)
    else
      return @pets = []
    end
  end

  def new
  end

  def create
    @user = User.find_by(name: params[:name])
    if !@user.nil?
      application = @user.applications.new(application_params)
      application.save
      redirect_to "/applications/#{application.id}"
    else
      flash.now[:alert] = 'Invalid user, must be a valid user.'
      render :new
    end
  end

  def update
    @application = Application.find(params[:application_id])
    if params[:pet_id]
      @application.add_pet(params[:pet_id])
      redirect_to "/applications/#{@application.id}"
    elsif params[:description].nil? || params[:description] == ''
      flash[:alert] = 'You must provide a description before we can submit your request.'
      redirect_to "/applications/#{@application.id}"
    elsif params[:description]
      @application.update(description: params[:description], status: 'Pending')
      redirect_to "/applications/#{@application.id}"
    end
  end

  private
  def application_params
    params.permit(:description, :status)
  end
end
