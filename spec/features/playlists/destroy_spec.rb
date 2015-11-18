require 'rails_helper'

describe 'Destroy Playlist' do
  let!(:playlist) { Playlist.create(name: 'Fun Stuff', description: 'Stuff that does not suck.') }

  it 'destroys a playlist' do
    visit playlists_path

    click_link 'Fun Stuff'
    click_link 'Edit'

    find('#delete').click

    expect(page).to have_content('Playlist was successfully destroyed.')
  end
end
