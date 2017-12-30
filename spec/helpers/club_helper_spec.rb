require 'rails_helper'

describe ClubHelper, type: :helper do
  let(:dummy_class)  { Class.new { include ClubHelper } }
  let(:created_club) { create(:club) }

  before do
    allow_any_instance_of(ClubHelper).to receive(:club_param).and_return(created_club.slug)
  end

  context '#club' do
    it 'returns the club' do
      expect(club).to eq(created_club)
    end
  end
end
