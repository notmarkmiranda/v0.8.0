class League < ApplicationRecord
  belongs_to :club
  has_many :user_league_roles
  has_many :users, through: :user_league_roles do
    def members
      where('user_league_roles.role = ?', 0)
    end

    def admins
      where('user_league_roles.role = ?', 1)
    end
  end

  validates :name, presence: true, uniqueness: { scope: :club_id }
  validates :slug, presence: true
  validates :club_id, presence: true

  def admin?(user)
    user_admins.include?(user)
  end

  def grant_adminship(user)
    add_person(user, 1)
  end

  def grant_membership(user)
    add_person(user, 0)
  end

  def has_person?(user)
    users.include?(user)
  end

  def is_stranger?(user)
    !has_person?(user)
  end

  def not_admin?(user)
    !admin?(user)
  end

  def user_admins
    users.admins
  end

  def user_members
    users.members
  end

  private

  def add_person(user, roletype)
    user_league_roles.where(user: user, league: self).destroy_all
    user_league_roles.create!(user: user, role: roletype)
  end
end
