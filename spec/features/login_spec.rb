require 'rails_helper'

RSpec.describe "Logging In" do
  it "can log in with valid credentials" do
    user = User.create(name: "Meg", email: "meg@test.com", password: "password123", password_confirmation: "password123")

    visit root_path
save_and_open_page
    click_on "Log In"

    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: user.password

    click_on "Log In as User"

    expect(current_path).to eq("/users/#{user.id}")

    expect(page).to have_content("Welcome, #{user.email}")
  end

  it "can redirect to log in if information is incorrect" do
    user = User.create(name: "Meg", email: "meg@test.com", password: "password123", password_confirmation: "password123")

    visit root_path

    click_on "Log In"

    expect(current_path).to eq('/login')

    fill_in :email, with: user.email
    fill_in :password, with: "megadeath"

    click_on "Log In as User"

    expect(current_path).to eq("/login")
  end
end
