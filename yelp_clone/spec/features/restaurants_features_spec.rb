require 'rails_helper'

feature 'restaurants' do

  before do
    sign_up
  end

  context 'no restaurants have been added' do
    scenario 'should display a prompt to add restaurants' do
      visit '/restaurants'
      expect(page).to have_content 'No restaurants yet'
      expect(page).to have_link 'Add a restaurant'
    end
  end

  context 'restaurants have been added' do
    before do
      Restaurant.create(name: 'KFC')
    end

    scenario 'displays restaurants' do
      visit '/restaurants'
      expect(page).to have_content('KFC')
      expect(page).not_to have_content('No restaurants yet')
    end
  end

  context 'creating restaurants' do
    # before do
    #   sign_up
    # end

    scenario 'should be able to add a restaurant' do
      visit '/restaurants'
      click_link "Add a restaurant"
      fill_in "Name", with: "KFC"
      click_button "Create Restaurant"
      expect(current_path).to eq "/restaurants"
      expect(page).to have_content "KFC"
    end

    scenario 'does not let you submit a name that is too short' do
      visit '/restaurants'
      click_link 'Add a restaurant'
      fill_in 'Name', with: 'kf'
      click_button 'Create Restaurant'
      expect(page).not_to have_css 'h2', text: 'kf'
      expect(page).to have_content 'error'
    end


    scenario 'if user signed out, they cannot add a new restaurant' do
      visit '/restaurants'
      click_link 'Sign Out'
      expect(page).to have_link "Add a restaurant"
      click_link "Add a restaurant"
      expect(page).to have_content "Log in"
    end

  end

  context 'viewing restaurants' do
    let!(:kfc) { Restaurant.create(name: 'KFC')}

    scenario 'lets a user view a restaurant' do
      visit '/restaurants'
      click_link 'KFC'
      expect(page).to have_content 'KFC'
      expect(current_path).to eq "/restaurants/#{kfc.id}"
    end
  end

  context 'editing restaurants' do
    before { Restaurant.create(name: 'KFC', description: 'Mmmm, love that skin') }

    scenario 'lets users edit restaurants' do
      visit '/restaurants'
      click_link "Edit KFC"
      fill_in 'Name', with: 'Kentucky Fried Chicken'
      fill_in 'Description', with: 'Deep fried goodness'
      click_button 'Update Restaurant'
      expect(page).to have_content 'Kentucky Fried Chicken'
      expect(page).to have_content 'Deep fried goodness'
      expect(current_path).to eq '/restaurants'
    end
  end

  context 'deleting restaurants' do
    before { Restaurant.create(name: 'KFC', description: 'Deep fried goodness')}

    scenario 'removes a restaurant when a user clicks a link' do
      visit '/restaurants'
      click_link 'Delete KFC'
      expect(page).not_to have_content 'KFC'
      expect(page).to have_content 'Restaurant deleted successfully'
    end
  end

end
