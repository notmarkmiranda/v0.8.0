class ClubsController < ApplicationController
  include ControllerHelper

  before_action :require_user, only: [:new, :create]
  before_action :verify_admin_for_club, only: [:edit, :update]

  def show
    @club = Club.find_by slug: params[:slug]
  end

  def new
    @club = current_user.clubs.new
  end

  def create
    @club = current_user.created_clubs.new(club_params)
    if @club.save
      redirect_to @club
    else
      render :new
    end
  end

  def edit
    @club = Club.find_by slug: params[:slug]
  end

  def update
    @club = Club.find_by(slug: params[:slug])
    if @club.update(club_params)
      redirect_to @club
    else
      render :edit
    end
  end

  private

  def club_params
    params.require(:club).permit(:name, :privated)
  end
end
