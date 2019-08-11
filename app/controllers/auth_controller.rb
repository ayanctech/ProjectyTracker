class AuthController < ApplicationController
  include AuthHelper

  def gettoken
    token = get_token_from_code params[:code]
    session[:azure_token] = token.to_hash
    redirect_to users_path
  end

end
