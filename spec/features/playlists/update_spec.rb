require 'rails_helper'

describe 'Update Playlist' do
  let!(:playlist) { Playlist.create(name: 'Good Stuff', description: 'Stuff that does not suck.') }

  it 'creates a new playlist' do
    visit playlists_path

    click_link 'Good Stuff'
    click_link 'Edit'
    fill_in 'Description', with: 'Stuff that mostly does not suck.'
    click_button 'Save Playlist'

    expect(page).to have_content('Playlist was successfully updated.')
    expect(page).to have_content('mostly')
  end
end
