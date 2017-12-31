class Club < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'
  has_many :user_club_roles
  has_many :leagues
  has_many :users, through: :user_club_roles do
    def members
      where('user_club_roles.role = ?', 0)
    end

    def admins
      where('user_club_roles.role = ?', 1)
    end
  end

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :user_id, presence: true

  after_create :create_admin_ucr
  before_validation :set_slug

  def admin?(user)
    user_admins.include?(user)
  end

  def grant_adminship(user)
    add_person(user, 1)
  end

  def grant_membership(user)
    add_person(user, 0)
  end

  def not_admin?(user)
    !admin?(user)
  end

  def to_param
    self.slug if slug
  end

  def user_admins
    users.admins
  end

  private

  def add_person(user, roletype)
    user_club_roles.where(user: user, club: self).destroy_all
    user_club_roles.create!(user: user, role: roletype)
  end

  def create_admin_ucr
    user_club_roles.create!(user_id: user_id, role: 1)
  end

  def set_slug
    self.slug = name.parameterize unless name.blank?
  end
end
