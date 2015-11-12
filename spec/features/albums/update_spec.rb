require 'rails_helper'

describe 'Update Album' do
  let!(:album) { Album.create(name: 'Rubber Factory', artist: 'The Black Keys', genre: 'Rock') }

  it 'creates a new album' do
    visit albums_path

    click_link 'Rubber Factory'
    click_link 'Edit'
    fill_in 'Genre', with: 'Blues Rock'
    click_button 'Save Album'

    expect(page).to have_content('Album was successfully updated.')
    expect(page).to have_content('Blues Rock')
  end
end
