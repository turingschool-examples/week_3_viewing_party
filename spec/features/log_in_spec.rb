require 'rails_helper'

RSpec.describe 'Log in Page' do
  before :each do 
      @user1 = User.create(name: "User One", email: "user1@test.com", password: "test1234", password_confirmation: "test1234")
      @user2 = User.create(name: "User Two", email: "user2@test.com", password: "test12345", password_confirmation: "test12345")
      visit '/'
  end 

  it 'when user enters their unique email and correct password they are taken to their dashboard page' do
    visit login_path

    fill_in :email, with: @user1.email
    fill_in :password, with: @user1.password

    click_button 'Log in'

    expect(current_path).to eq(user_path(@user1.id))
    expect(page).to have_content("#{@user1.name}'s Dashboard")
  end

  it 'user cant login when the credentials are incorrect' do
    visit login_path

    fill_in :email, with: @user2.email
    fill_in :password, with: @user1.password

    click_button 'Log in'

    expect(current_path).to eq(login_path)
    expect(page).to have_content(/Wrong Credentials/)
  end
end