require 'rails_helper'

RSpec.describe Playlist, type: :model do
  let(:valid_attributes) {
    {
        name: 'Fun Stuff',
        description: 'Stuff that does not suck.',
    }
  }

  context 'validations' do
    it 'has name' do
      should allow_value('Fun Stuff').for(:name)
      should_not allow_value('').for(:name)
    end
  end

  context 'creation' do
    it 'can create playlists' do
      Playlist.create(valid_attributes)
      expect(Playlist.last).to be_truthy
      expect(Playlist.last.name).to eq('Fun Stuff')
    end
  end
end
