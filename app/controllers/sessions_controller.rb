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
      @auth_user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
      
      unless @auth_user
        @auth_user = User.new(
          provider: auth["provider"],
          uid: auth["uid"],
          email: auth["info"]["email"],
          first_name: auth["info"]["first_name"],
          last_name: auth["info"]["last_name"],
          image: auth["info"]["image"],
          password_digest: "#{Time.now.strftime('%d/%m/%Y-%H:%M:%S')}-#{rand.to_s[2..10]}",
          google_signup: true 
        )
        
        @auth_user.save(validate: false) 
      end

      session[:user_id] = @auth_user.id
      redirect_to '/', notice: "Logged in as #{auth_user.first_name} #{auth_user.last_name} 👍"
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
