require 'rails_helper'

describe 'Displaying Albums' do

  let!(:album) { Album.create(name: 'Rubber Factory', artist: 'The Black Keys') }

  it 'displays albums' do
    visit albums_path

    expect(page).to have_content('Rubber Factory')
  end
end
