require 'rails_helper'

describe User, type: :model do
  context 'relationships'
  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }

    it { should validate_uniqueness_of :email }
  end

  context 'methods' do
    let(:user) { create(:user, first_name: 'Mark', last_name: 'Miranda') }

    context '#full_name' do
      it 'returns the full name of the user' do
        expect(user.full_name).to eq('Mark Miranda')
      end
    end
  end
end
