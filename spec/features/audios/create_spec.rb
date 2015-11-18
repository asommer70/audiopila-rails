require 'rails_helper'

describe 'Create Audios' do

  let!(:repositories) { Settings.repositories = ['/Users/adam/Music'] }

  it 'creates a new audio' do
    visit '/audios/new'

    fill_in 'Name', with: 'test.mp3'
    fill_in 'Path', with: '/Users/adam/Music/test.mp3'
    click_button 'Save Audio File'

    expect(page).to have_content('Audio was successfully created.')
    expect(page).to have_content('test.mp3')
  end

  it 'creates a network audio' do
    visit '/audios/new'

    fill_in 'Name', with: 'Static Memories.mp3'
    fill_in 'Path', with: 'http://www.nihilus.net/soundtracks/Static%20Memories.mp3'
    click_button 'Save Audio File'

    expect(page).to have_content('Audio was successfully created.')
    expect(page).to have_content('Static Memories.mp3')
  end

  it 'will sync repository directory' do
    visit '/'
    find('#repo_sync_0').click

    expect(page).to have_content('Repository sync successful.')
  end

  it 'creates an audio with an album', js: true do
    visit albums_path

    click_link 'New Album'
    fill_in 'Name', with: 'Rubber Factory'
    fill_in 'Artist', with: 'The Black Keys'
    fill_in 'Year', with: '2004'
    fill_in 'Genre', with: 'Rock'
    click_button 'Save Album'
    album = Album.last

    visit '/audios/new'

    fill_in 'Name', with: 'When the Lights Go Out.mp3'
    fill_in 'Path', with: '/Users/adam/Music/When the Lights Go Out.mp3'
    #album_field = find('input.default')
    #album_field.set(album.name)
    find('.chosen-single.chosen-default').click
    find('li.active-result.highlighted').click
    click_button 'Save Audio File'

    audio = Audio.last

    expect(page).to have_content('Audio was successfully created.')
    expect(page).to have_content('When the Lights Go Out.mp3')
    expect(page).to have_content('Rubber Factory')
    expect(audio.album).to eq(album)
  end
end
