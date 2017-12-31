require 'rails_helper'

describe User, type: :model do
  let(:user) { create(:user, first_name: 'Mark', last_name: 'Miranda') }

  context 'relationships' do
    it { should have_many :created_clubs }
    it { should have_many :user_club_roles }
    it { should have_many :clubs }

    context 'clubs' do
      let(:club)  { create(:club) }
      let(:admin) { club.creator }
      let(:member) do
        club.grant_membership(user)
        user
      end

      context '#clubs.admin' do
        it 'returns clubs where user is an admin' do
          expect(admin.clubs.admin).to match_array([club])
        end

        it 'returns an empty array' do
          club.grant_membership(admin)

          expect(admin.clubs.admin).to eq([])
        end
      end

      context '#clubs.member' do
        it 'returns clubs where user is a member' do
          expect(member.clubs.member).to match_array([club])
        end

        it 'returns an empty array' do
          expect(user.clubs.member).to eq([])
        end
      end
    end

    it { should have_many :user_league_roles }
    it { should have_many :leagues }
    context 'leagues' do
      let(:league) { create(:league) }
      let(:admin)  { league.club.creator }

      context '#leagues.admin' do
        it 'returns leagues where user is an admin' do
          league.grant_adminship(admin)

          expect(admin.leagues.admin).to match_array([league])
        end

        it 'returns an empty array' do
          expect(admin.leagues.admin).to eq([])
        end
      end

      context '#leagues.member' do
        it 'returns leagues where user is a member' do
          league.grant_membership(admin)

          expect(admin.leagues.member).to match_array([league])
        end

        it 'returns an empty array' do
          expect(admin.leagues.member).to eq([])
        end
      end
    end
  end

  context 'validations' do
    it { should validate_presence_of :email }
    it { should validate_uniqueness_of :email }
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
  end

  context 'methods' do
    context '#full_name' do
      it 'returns the full name of the user' do
        expect(user.full_name).to eq('Mark Miranda')
      end
    end
  end
end
