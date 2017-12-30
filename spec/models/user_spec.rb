require 'rails_helper'

describe User, type: :model do
  context 'relationships'
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }

    it { should validate_uniqueness_of :email }

  end
  context 'methods'
end
