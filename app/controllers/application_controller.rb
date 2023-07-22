class ApplicationController < ActionController::Base
  include ApplicationHelper
  include SessionsHelper

  before_action :authenticate_user!
  helper_method :current_user
  helper_method :logged_in?
  before_action :restrict_auth_page
  
  rescue_from CanCan::AccessDenied do |exception|
    flash[:notice] = "You are not authorized to perform this action🚫"
  end
end
