# Eithery Lab, 2016.
# ApplicationController.
# Represents a base class for all controllers within the application.

class ApplicationController < ActionController::Base
  include SessionsHelper
  protect_from_forgery with: :exception

private

  def assert_authenticated_user
    redirect_to login_path unless logged_in?
  end
end
