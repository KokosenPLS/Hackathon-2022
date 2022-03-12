class ProfileController < ApplicationController
  before_action :set_profile

  def profile

  end

  def rentals

  end

  private

  def set_profile
    @user = User.find(params[:id])
  end

end
