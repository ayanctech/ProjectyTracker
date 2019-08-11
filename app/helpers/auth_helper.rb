module AuthHelper

  CLIENT_ID = "e857af08-5389-4f3c-9f07-18e08fedb377"
  CLIENT_SECRET = ".Yl7?p@tG34R+ZpiDyzVbXUDgSYSKw0Q"

  SCOPES = [ "openid",
             "profile",
             "offline_access",
             "User.Read",
             "Mail.Read" ]

  REDIRECT_URI = "http://localhost:3000/authorize"

  def get_login_url
    client = OAuth2::Client.new(CLIENT_ID,
                                CLIENT_SECRET,
                                :site => "https://login.microsoftonline.com",
                                :authorize_url => "/common/oauth2/v2.0/authorize",
                                :token_url => "/common/oauth2/v2.0/token")

    login_url = client.auth_code.authorize_url(:redirect_uri => authorize_url, :scope => SCOPES.join(" "))
  end

  # Exchanges an authorization code for a token
def get_token_from_code(auth_code)
  client = OAuth2::Client.new(CLIENT_ID,
                              CLIENT_SECRET,
                              :site => 'https://login.microsoftonline.com',
                              :authorize_url => '/common/oauth2/v2.0/authorize',
                              :token_url => '/common/oauth2/v2.0/token')

  token = client.auth_code.get_token(auth_code,
                                     :redirect_uri => authorize_url,
                                     :scope => SCOPES.join(' '))
end

# Exchanges an authorization code for a token
def get_token_from_code(auth_code)
  client = OAuth2::Client.new(CLIENT_ID,
                            CLIENT_SECRET,
                            :site => 'https://login.microsoftonline.com',
                            :authorize_url => '/common/oauth2/v2.0/authorize',
                            :token_url => '/common/oauth2/v2.0/token')

  token = client.auth_code.get_token(auth_code,
                                   :redirect_uri => authorize_url,
                                   :scope => SCOPES.join(' '))
end

# Gets the current access token
def get_access_token
  # Get the current token hash from session
  token_hash = session[:azure_token]

  client = OAuth2::Client.new(CLIENT_ID,
                              CLIENT_SECRET,
                              :site => 'https://login.microsoftonline.com',
                              :authorize_url => '/common/oauth2/v2.0/authorize',
                              :token_url => '/common/oauth2/v2.0/token')

  token = OAuth2::AccessToken.from_hash(client, token_hash)

  # Check if token is expired, refresh if so
  if token.expired?
    new_token = token.refresh!
    # Save new token
    session[:azure_token] = new_token.to_hash
    access_token = new_token.token
  else
    access_token = token.token
  end
end

end
