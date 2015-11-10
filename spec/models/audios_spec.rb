require 'rails_helper'

RSpec.describe Audio, type: :model do
  let(:valid_attributes) {
    {
        name: 'test1.mp3',
        path: '~/Music/test1.mp3',
    }
  }

  context 'validations' do
    it 'has name and path' do
      should allow_value('test2.mp3').for(:name)
      should allow_value('~/Music/test2.mp3').for(:path)
      should_not allow_value('').for(:name)
      should_not allow_value('').for(:path)
    end
  end

  context 'creation' do
    it 'can create repositories settings' do
      Audio.create(valid_attributes)
      expect(Audio.last).to be_truthy
      expect(Audio.last.name).to eq('test1.mp3')
    end
  end
end
