require 'doorkeeper/orm/active_record/application'

Doorkeeper.configure do
  orm :active_record

  # This block will be called to check whether the resource owner is authenticated or not.
  resource_owner_authenticator do
    current_user || warden.authenticate!(scope: :user)
  end

  resource_owner_from_credentials do |routes|
    user = User.find_for_database_authentication(email: params[:username])
    if user&.valid_password?(params[:password])
      user
    end
  end

  client_credentials :from_basic, :from_params

  access_token_expires_in 1.hour
  use_refresh_token

  grant_flows %w[password client_credentials refresh_token]

  default_client = Doorkeeper::Application.find_by(uid: 'ZK9kWWyutt3KlC0tMpBKa7XQNlMRwXbIHUVi_MN5ZMQ')
  default_client&.secret = 'esxMsb7maq2wv0lgsT8-uimUrhNQjs3Wp7x5Lvs1bAs' if default_client
end
