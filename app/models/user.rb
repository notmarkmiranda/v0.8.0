class User < ApplicationRecord
  has_secure_password
  has_secure_token

  has_many :created_clubs, class_name: 'Club', foreign_key: :user_id
  has_many :user_club_roles
  has_many :clubs, through: :user_club_roles do
    def member
      where('user_club_roles.role = ?', 0)
    end

    def admin
      where('user_club_roles.role = ?', 1)
    end
  end
  has_many :user_league_roles
  has_many :leagues, through: :user_league_roles do
    def member
      where('user_league_roles.role = ?', 0)
    end

    def admin
      where('user_league_roles.role = ?', 1)
    end
  end

  validates :email, presence: true, uniqueness: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end
end
