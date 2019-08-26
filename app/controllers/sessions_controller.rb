class SessionsController < ApplicationController

  def new
  end

  def create
    user= User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if user.email_confirmed
        session[:user_id] = user.id
        redirect_to root_path, info: "Logged In!"
      else
        redirect_to new_user_path, flash: { warning: "PLease confirm your email before login !" }
      end
    else
      flash.now[:warning] = "Email or Password invalid !"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end
  
end
