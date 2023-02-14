require 'rails_helper'

RSpec.describe 'Landing Page' do
    before :each do 
        @user1 = User.create(name: "User One", email: "user1@test.com", password: "test1234", password_confirmation: "test1234")
        @user2 = User.create(name: "User Two", email: "user2@test.com", password: "test12345", password_confirmation: "test12345")
        visit '/'
    end 

    it 'has a header' do
        expect(page).to have_content('Viewing Party Lite')
    end

    it 'has links/buttons that link to correct pages' do 
        click_button "Create New User"
        
        expect(current_path).to eq(register_path) 
        
        visit '/'

        click_link "Home"
        expect(current_path).to eq(root_path)
    end 

    it 'lists out existing users' do 
        # @user1 = User.create(name: "User One", email: "user1@test.com", password: "test1234", password_confirmation: 'test1234')
        # @user2 = User.create(name: "User Two", email: "user2@test.com", password: "test12214", password_confirmation: 'test12214')

        expect(page).to have_content('Existing Users:')

        within('.existing-users') do 
            expect(page).to have_content(@user1.email)
            expect(page).to have_content(@user2.email)
        end     
    end 

    it 'has link for log in' do
        expect(page).to have_button('Log In')
    end

    it 'when log in is clicked user is taken to log in page where they can enter their unique email and password' do
        click_button 'Log In'

        expect(current_path).to eq('/login')
        expect(page).to have_field(:email)
        expect(page).to have_field(:password)
    end

    it 'after user logs in, they no longer see a link to log in or create an account in the landing page' do
        click_button 'Log In'

        fill_in :email, with: @user1.email
        fill_in :password, with: @user1.password

        click_button 'Log in'
        click_link 'Home'

        expect(page).to_not have_button('Log In')
        expect(page).to_not have_button('Create New User')
        expect(page).to have_button('Log Out')
    end

    it 'when log out is clicked user is taken back to the landing page and can see log in and create user buttons again' do
        click_button 'Log In'

        fill_in :email, with: @user1.email
        fill_in :password, with: @user1.password

        click_button 'Log in'
        click_link 'Home'
        click_button 'Log Out'

        expect(page).to have_button('Log In')
        expect(page).to have_button('Create New User')
        expect(page).to_not have_button('Log Out')
    end
end
