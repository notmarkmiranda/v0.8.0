module ControllerHelper
  def club
    @club ||= Club.find_by(slug: club_param)
  end

  def league
    @league ||= League.find_by(slug: league_param)
  end

  def reject_access
    return go_to_sign_in_path if current_user.nil?
    return redirect_to dashboard_path if controller_name == 'clubs' && club.not_admin?(current_user)
    # return redirect_to dashboard_path if controller_name == 'leagues' && league.admin?(current_user)
  end

  private

  def go_to_sign_in_path
    redirect_to sign_in_path
  end

  def club_param
    controller_name == 'clubs' ? params[:slug] : params[:club_slug]
  end

  def league_param
    controller_name == 'leagues' ? params[:slug] : params[:league_slug]
  end

end
