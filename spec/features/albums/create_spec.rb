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
end
