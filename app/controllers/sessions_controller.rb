class SessionsController < ApplicationController
  skip_before_action :authenticate_user!, only: [:new, :create, :create_auth_user]

  def new; end

  def create
    reset_session
    @user = User.find_by(username: session_params[:username])
    if @user && @user.authenticate(session_params[:password])
      log_in(@user)
      flash[:notice] = "Welcome Back #{current_user.full_name} 👍"
      redirect_to '/'
    else
      flash[:alert] = 'Invalid email/password combination ❌'
      redirect_to '/login'
    end
  end

  def create_auth_user
    auth = request.env["omniauth.auth"]
    begin
      if (User.find_by_provider_and_uid(auth["provider"], auth["uid"]))
        @auth_user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      else
        @auth_user = User.new
        @auth_user.provider = auth["provider"]
        @auth_user.uid = auth["uid"]
        @auth_user.username = auth["info"]["username"]
        @auth_user.email = auth["info"]["email"]
        @auth_user.phone_number = auth["info"]["phone_number"]
        @auth_user.full_name = auth["info"]["full_name"]
        @auth_user.image = auth["info"]["image"]
        @auth_user.password_digest = "#{Time.now.strftime('%d/%m/%Y-%H:%M:%S')}-#{rand.to_s[2..10]}"
        @auth_user.save!
      end
      session[:user_id] = @auth_user.id
      redirect_to '/', notice: "Logged in as #{@auth_user.full_name} 👍"
    rescue StandardError
      flash[:alert] = @auth_user.errors.full_messages.join(', ')
      redirect_to '/login'
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to '/login', notice: 'Logged out!'
  end

  private

  def session_params
    params.require(:session).permit(:username, :password)
  end
end
