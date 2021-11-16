class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      session[:user_id] = user.id
      flash[:notice] = "logoneado succesfully"
      redirect_to user
    else
      flash.now[:alert] = "hubo un problema con sus datos de logoneo"
      render 'new'
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "deslogueado"
    redirect_to root_path
  end


end
