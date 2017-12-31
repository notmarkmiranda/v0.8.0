module ControllerHelper
  def club
    @club ||= Club.find_by(slug: club_param)
  end

  def league
    @league ||= League.find_by(slug: league_param)
  end

  def reject_access
    return redirect_to sign_in_path if current_user.nil?
    if controller_name == 'clubs'
      redirect_to dashboard_path unless club.users.admins.include?(current_user)
    elsif controller_name == 'leagues'
      redirect_to dashboard_path unless league.users.admins.include?(current_user)
    end
  end

  private

  def club_param
    controller_name == 'clubs' ? params[:slug] : params[:club_slug]
  end

  def league_param
    controller_name == 'leagues' ? params[:slug] : params[:league_slug]
  end

end
