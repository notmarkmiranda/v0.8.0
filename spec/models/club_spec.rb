require 'rails_helper'

describe Club, type: :model do
  let(:club)  { create(:club) }
  let(:admin) { club.creator }
  let(:member) do
    user = create(:user)
    club.grant_membership(user)
    user
  end

  context 'relationships' do
    it { should belong_to :creator }
    it { should have_many :user_club_roles }
    it { should have_many :users }
    context '#users.members' do

      it 'returns members' do
        member
        expect(club.users.members).to match_array([member])
      end

      it 'returns an empty array' do
        expect(club.users.members).to eq([])
      end
    end

    context '#users.admin' do
      it 'returns admins' do
        expect(club.users.admins).to match_array([admin])
      end

      it 'returns an empty array' do
        club.grant_membership(admin)
        expect(club.users.admins).to eq([])
      end
    end
  end

  context 'validations' do
    it { should validate_presence_of :name }
    it do
      create(:club)
      should validate_uniqueness_of :name
    end
    it { should validate_presence_of :slug }
    it { should validate_presence_of :user_id }
  end

  context 'methods' do
    context '#grant_adminship' do
      it 'adds person as an admin and removes them as a member' do
        member

        expect {
          club.grant_adminship(member)
        }.to change { club.users.admins.count }.from(1).to(2)
          .and change { club.users.members.count }.from(1).to(0)
      end
    end

    context '#grant_membership' do
      it 'adds a person as a member and removes them as an admin' do
        member

        expect {
          club.grant_membership(admin)
        }.to change { club.users.admins.count }.from(1).to(0)
          .and change { club.users.members.count }.from(1).to(2)
      end
    end
  end
end
