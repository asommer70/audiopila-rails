require 'rails_helper'

RSpec.describe Settings, type: :model do

  let(:valid_attributes) {
    {
        var: 'respositories',
        value: ['~/Music'],
    }
  }

  context 'creation' do
    it 'can create repositories settings' do
      Settings.create(valid_attributes)
      expect(Settings.repositories).to be_truthy
      expect(Settings.repositories[0]).to eq('~/Music')
    end
  end
end
