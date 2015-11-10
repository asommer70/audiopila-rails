require 'rails_helper'

describe 'Destroy Audios' do

  let!(:repositories) { Settings.repositories = ['/Users/adam/Music'] }
  let!(:audio) { Audio.create(name: 'test.mp3', path: '/Users/adam/Music/test.mp3') }

  before do
    `touch #{audio.path}`
  end

  it 'destroys an audio' do
    visit audio_path(audio)
    expect(page).to have_content('test.mp3')

    click_link 'Edit'
    find('#delete').click

    expect(page).to have_content('Audio was successfully destroyed.')
  end

  it 'will destroy an audio when repository is synced' do
    `rm #{audio.path}`

    visit '/'
    find('#repo_sync_0').click

    expect(page).to have_content('Repository sync successful.')
    expect(page).to_not have_content('test.mp3')
  end
end
