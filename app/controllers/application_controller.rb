require 'microsoft_graph_auth'
require 'oauth2'

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

  helper_method :current_user, :auto_generate_id

  def logged_in?
    current_user
  end

  def login_required
    unless logged_in?
      redirect_to  new_session_path, flash: { danger: "You must first log in or sign up before accessing this page." }
    end
  end


  def save_in_session(auth_hash)
    session[:graph_token_hash] = auth_hash.dig(:credentials)

    session[:user_name] = auth_hash.dig(:extra, :raw_info, :displayName)

    session[:user_email] = auth_hash.dig(:extra, :raw_info, :mail) ||
                           auth_hash.dig(:extra, :raw_info, :userPrincipalName)
  end

  def user_name
    session[:user_name]
  end

  def user_email
    session[:user_email]
  end

  def access_token
    session[:graph_token_hash][:token]
  end


  def refresh_tokens(token_hash)
    oauth_strategy = OmniAuth::Strategies::MicrosoftGraphAuth.new(
      nil, ENV['AZURE_APP_ID'], ENV['AZURE_APP_SECRET']
    )

    token = OAuth2::AccessToken.new(
      oauth_strategy.client, token_hash[:token],
      refresh_token: token_hash[:refresh_token]
    )

    new_tokens = token.refresh!.to_hash.slice(:access_token, :refresh_token, :expires_at)


    new_tokens[:token] = new_tokens.delete :access_token

    session[:graph_token_hash] = new_tokens
  end

  def access_token
    token_hash = session[:graph_token_hash]

    expiry = Time.at(token_hash[:expires_at] - 300)

    if Time.now > expiry
      new_hash = refresh_tokens token_hash
      new_hash[:token]
    else
      token_hash[:token]
    end
  end


  def set_user
    @user_name = user_name
    @user_email = user_email
  end

  def auto_generate_id
    SecureRandom.random_number(1_000_000)
  end
  
end
