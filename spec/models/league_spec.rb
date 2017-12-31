require 'rails_helper'

describe League, type: :model do
  context 'relationships' do
    it { should belong_to :club }
  end

  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:club_id) }
    it { should validate_presence_of :slug }
    it { should validate_presence_of :club_id }
  end
  context 'methods'
end
