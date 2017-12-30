class UserClubRole < ApplicationRecord
  belongs_to :user
  belongs_to :club

  validates :user_id, presence: true, uniqueness: { scope: :club_id }
  validates :club_id, presence: true
  validates :role, inclusion: { in: [0, 1] }
end
