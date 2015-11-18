require 'rails_helper'

RSpec.describe Album, type: :model do
  let(:valid_attributes) {
    {
        name: 'Rubber Factory',
        artist: 'The Black Keys',
    }
  }

  context 'validations' do
    it 'has name and path' do
      should allow_value('Rubber Factory').for(:name)
      should allow_value('The Black Keys').for(:artist)
      should_not allow_value('').for(:name)
      should_not allow_value('').for(:artist)
    end
  end

  context 'creation' do
    it 'can create albums' do
      Album.create(valid_attributes)
      expect(Album.last).to be_truthy
      expect(Album.last.name).to eq('Rubber Factory')
    end
  end
end
