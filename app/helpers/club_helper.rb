module ClubHelper
  def club
    @club ||= Club.find_by(slug: club_param)
  end

  def verify_admin_for_club
    return redirect_to sign_in_path if current_user.nil?
    redirect_to dashboard_path unless current_user && club.users.admins.include?(current_user)
  end

  private

  def club_param
    controller_name == 'clubs' ? params[:slug] : params[:club_slug]
  end

end
