class LeaguesController < ApplicationController
  include ControllerHelper
  before_action :access_to_private_league

  def show
  end

  private

  def access_to_private_league
    if league.privated?
      return redirect_to sign_in_path if current_user.nil?
      redirect_to dashboard_path if league.is_stranger?(current_user)
    end
  end
end
