class SessionsController < ApplicationController
  def new

  end

  def create
    user = User.find_by(email: params[:email])

    if user&.authenticate(params[:password])
      session[:user_id] = user.id
    else
      render :new
    end
  end

  def destroy
    session[:user_id] = nil if session[:user_id]
    redirect_to root_path
  end
end
