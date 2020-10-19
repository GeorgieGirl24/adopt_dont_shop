class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @user = User.find(@application.user_id)
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

  private
  def application_params
    params.permit(:description, :status)
  end
end
