class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]
  before_action :authenticate_user!, except: [:create]
  load_and_authorize_resource except: [:create, :new]

  def index
    @user = current_user
  end

  def show; end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in(@user)
      flash[:notice] = "Welcome #{current_user.full_name} 👍"
      redirect_to '/'
    else
      if (@user.errors.full_messages).uniq! == nil
        error = @user.errors.full_messages
      else
        error = (@user.errors.full_messages).uniq!
      end
      flash[:alert] = error.join(', ')
      redirect_to '/register'
    end
  end

  def update
    @user.update(user_params)
    flash[:success] =  'User Updated Successfully 👍'
    redirect_to '/'
  end

  def destroy
    @user.destroy
    flash[:success] =  'User Deleted ❌'
    redirect_to '/login'
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:provider, :uid, :username, :full_name, :email, :phone_number, :image, :role, :status, :password, :password_confirmation)  
  end
end
