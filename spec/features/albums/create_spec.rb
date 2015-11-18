require 'rails_helper'

describe 'Create Albums' do

  it 'creates a new album' do
    visit albums_path

    click_link 'New Album'

    fill_in 'Name', with: 'Rubber Factory'
    fill_in 'Artist', with: 'The Black Keys'
    fill_in 'Year', with: '2004'
    fill_in 'Genre', with: 'Rock'
    click_button 'Save Album'

    expect(page).to have_content('Album was successfully created.')
    expect(page).to have_content('Rubber Factory')
  end

  it 'creates a new album and adds an audio', js: true do
    visit '/audios/new'

    fill_in 'Name', with: 'When the Lights Go Out.mp3'
    fill_in 'Path', with: '/Users/adam/Music/When the Lights Go Out.mp3'
    click_button 'Save Audio File'
    audio = Audio.last

    visit albums_path

    click_link 'New Album'

    fill_in 'Name', with: 'Rubber Factory'
    fill_in 'Artist', with: 'The Black Keys'
    fill_in 'Year', with: '2004'
    fill_in 'Genre', with: 'Rock'

    audios_field = find('input.default')
    audios_field.set(audio.name)
    find('.active-result').click
    click_button 'Save Album'

    album = Album.last

    expect(page).to have_content('Album was successfully created.')
    expect(page).to have_content('Rubber Factory')
    expect(album.audios.count).to eq(1)
  end
end
