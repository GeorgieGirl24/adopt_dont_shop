class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @user = User.find(@application.user_id)
  end
end
