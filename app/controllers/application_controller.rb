class ApplicationController < ActionController::Base

  protected
  def authenticate_user!
    redirect_to new_user_session_path, notice: "You must login" unless user_signed_in?
  end

end
