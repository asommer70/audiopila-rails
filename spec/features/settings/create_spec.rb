require 'rails_helper'

describe 'Create Settings' do
  it 'creates a new repository', js: true do
    visit '/settings'

    fill_in 'Music Repository path', with: '~/Music'
    click_button 'Save Settings'

    expect(page).to have_content('Setting was successfully saved.')
    expect(page).to have_content('~/Music')
  end
end
