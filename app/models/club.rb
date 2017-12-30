class Club < ApplicationRecord
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  validates :name, presence: true, uniqueness: true
  validates :slug, presence: true
  validates :user_id, presence: true

  before_validation :set_slug

  def to_param
    self.slug if slug
  end
  private

  def set_slug
    self.slug = name.parameterize unless name.blank?
  end
end
