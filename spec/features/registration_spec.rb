require 'rails_helper'

RSpec.describe "User Registration" do
  it 'can create a user with a name and unique email' do
    visit register_path

    fill_in :user_name, with: 'User One'
    fill_in :user_email, with:'user1@example.com'
    fill_in :user_password, with: 'test'
    click_button 'Create New User'

    expect(current_path).to eq(user_path(User.last.id))
    expect(page).to have_content("User One's Dashboard")
  end 

  it 'does not create a user if email isnt unique' do 
    User.create(name: 'User One', email: 'notunique@example.com', password: 'monkey', password_confirmation: "monkey")

    visit register_path
    
    fill_in :user_name, with: 'User Two'
    fill_in :user_email, with:'notunique@example.com'
    fill_in :user_password, with: 'test'
    click_button 'Create New User'

    expect(current_path).to eq(register_path)
    expect(page).to have_content("Email has already been taken")
    
  end

  it 'creates a new user with a password' do
    visit register_path

    fill_in :user_name, with: 'billybob'
    fill_in :user_email, with: 'billy.bob@gmail.com'
    fill_in :user_password, with: 'sample password'
    fill_in :user_password_confirmation, with: "sample password"

    click_button 'Create New User'
    expect(page).to have_content("billybob's Dashboard")
    expect(page).to have_content("Welcome, #{User.last.name}!")
  end

  describe 'sad path' do
    it "user fails to fill in name or email or password and gets a pop up message" do
      visit register_path

      fill_in :user_name, with: ''
      fill_in :user_email, with: 'billy.bob@gmail.com'
      fill_in :user_password, with: 'sample password'
      fill_in :user_password_confirmation, with: "sample password"

      click_button 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content(/Name can't be blank/)
      
      visit register_path

      fill_in :user_name, with: 'Pam'
      fill_in :user_email, with: ''
      fill_in :user_password, with: 'sample password'
      fill_in :user_password_confirmation, with: "sample password"

      click_button 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content(/Email can't be blank/)
      visit register_path

      fill_in :user_name, with: 'Bill'
      fill_in :user_email, with: 'billy.bob@gmail.com'
      fill_in :user_password, with: ''
      fill_in :user_password_confirmation, with: "sample password"

      click_button 'Create New User'
      expect(current_path).to eq(register_path)
      expect(page).to have_content(/Password can't be blank/)
    end
  end
end
