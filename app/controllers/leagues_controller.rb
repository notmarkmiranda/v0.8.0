class LeaguesController < ApplicationController
  include ControllerHelper
  before_action :access_to_private_league

  def show
  end

  private

  def access_to_private_league
    reject_access unless !league.privated? || league.users.include?(current_user)
  end
end
