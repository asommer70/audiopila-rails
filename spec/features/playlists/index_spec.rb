require 'rails_helper'

describe 'Displaying Playlists' do

  let!(:playlist) { Playlist.create(name: 'Good Stuff', description: 'Stuff that does not suck.') }

  it 'displays playlists' do
    visit playlists_path

    expect(page).to have_content('Good Stuff')
  end
end
