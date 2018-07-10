class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
    #user must be logged in for all actions. Exceptions to be added
  before_action :authenticate_user!
end
