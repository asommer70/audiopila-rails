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
end
