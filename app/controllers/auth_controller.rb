class AuthController < ApplicationController

  def signin
    redirect_to "/auth/microsoft_graph_auth"
  end

  def callback
    # Access the authentication hash for omniauth
    data = request.env["omniauth.auth"]
    @user = User.find_or_create_from_auth_hash(request.env["omniauth.auth"])
    session[:user_id]=@user.id

    save_in_session data

    redirect_to root_url

  end

  def signout
    reset_session
    redirect_to root_url
  end

end
