class League < ApplicationRecord
  belongs_to :club

  validates :name, presence: true, uniqueness: { scope: :club_id }
  validates :slug, presence: true
  validates :club_id, presence: true
end
