class ApplicationController < ActionController::Base
  protect_from_forgery

  private
  def current_user
    logger = Rails.logger
    logger.debug "****#{session[:user_id]}****"
    if session[:user_id] && User.exists?(id: session[:user_id])
      @current_user ||= User.find(session[:user_id])
    end
  end

  helper_method :current_user

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      redirect_to  new_session_path, flash: { danger: "You must first log in or sign up before accessing this page." }
    end
  end


end
