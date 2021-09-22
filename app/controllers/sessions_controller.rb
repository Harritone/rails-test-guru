class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:email])
    # byebug

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to cookies[:path].present? ? cookies[:path] : root_path
    else
      flash.now[:alert] = 'Are you a Guru yet? Verify your Email and Password please.'
      render :new
      # redirect_to sign_in_path 
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end
end
