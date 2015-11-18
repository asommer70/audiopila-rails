require 'rails_helper'

describe 'Create Playlists' do

  it 'creates a new playlist' do
    visit playlists_path

    click_link 'New Playlist'

    fill_in 'Name', with: 'Fun Stuff'
    fill_in 'Description', with: 'Stuff that does not suck.'
    click_button 'Save Playlist'

    expect(page).to have_content('Playlist was successfully created.')
    expect(page).to have_content('Fun Stuff')
  end

  it 'creates a new playlist and adds an audio', js: true do
    visit '/audios/new'

    fill_in 'Name', with: 'When the Lights Go Out.mp3'
    fill_in 'Path', with: '/Users/adam/Music/When the Lights Go Out.mp3'
    click_button 'Save Audio File'
    audio = Audio.last

    visit playlists_path

    click_link 'New Playlist'

    fill_in 'Name', with: 'Fun Stuff'
    fill_in 'Description', with: 'Stuff that does not suck.'

    audios_field = find('input.default')
    audios_field.set(audio.name)
    find('.active-result').click
    click_button 'Save Playlist'

    playlist = Playlist.last

    expect(page).to have_content('Playlist was successfully created.')
    expect(page).to have_content('Fun Stuff')
    expect(playlist.audios.count).to eq(1)
  end
end
