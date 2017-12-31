require 'rails_helper'

describe League, type: :model do
  let(:league) { create(:league) }
  let(:user)   { create(:user) }
  let(:admin) do
    admin_user = league.club.creator
    league.grant_adminship(admin_user)
    admin_user
  end
  let(:member) do
    league.grant_membership(user)
    user
  end

  context 'relationships' do
    it { should belong_to :club }
    context 'users' do

      context '#users.admin' do
        it 'returns users that are admins' do
          league.grant_adminship(member)
          expect(league.user_admins).to match_array([admin, member])
        end

        it 'returns an empty array when there are no admins' do
          league.grant_membership(admin)
          expect(league.user_admins).to eq([])
        end
      end

      context '#users.members' do
        it 'returns users that are members' do
          league.grant_membership(admin)
          expect(league.user_members).to match_array([admin, member])
        end

        it 'returns an empty array when there are no members' do
          expect(league.user_members).to eq([])
        end
      end
    end
  end

  context 'validations' do
    it { should validate_presence_of :name }
    it { should validate_uniqueness_of(:name).scoped_to(:club_id) }
    it { should validate_presence_of :slug }
    it { should validate_presence_of :club_id }
  end

  context 'methods' do
    context '#grant_adminship' do
      it 'adds a user as an admin' do
        expect(league.user_admins).to match_array([admin])
        league.grant_adminship(member)

        expect(league.user_admins).to match_array([admin, member])
      end
    end

    context '#grant_membership' do
      it 'adds a user as an member' do
        expect(league.user_members).to match_array([member])
        league.grant_membership(admin)

        expect(league.user_members).to match_array([admin, member])
      end
    end
  end
end
