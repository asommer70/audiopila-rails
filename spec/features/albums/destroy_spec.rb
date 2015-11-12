require 'rails_helper'

describe 'Destroy Album' do
  let!(:album) { Album.create(name: 'Rubber Factory', artist: 'The Black Keys', genre: 'Rock') }

  it 'creates a new album' do
    visit albums_path

    click_link 'Rubber Factory'
    click_link 'Edit'

    find('#delete').click

    expect(page).to have_content('Album was successfully destroyed.')
  end
end
