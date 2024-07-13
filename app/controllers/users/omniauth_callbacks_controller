class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def google_oauth2
    @user = User.from_omniauth(request.env["omniauth.auth"])

    if @user.persisted?
      render json: @user
    else
      render json: { error: 'Failed to authenticate via Google' }, status: :unauthorized
    end
  end
end
