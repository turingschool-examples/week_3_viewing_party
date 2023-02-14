require 'rails_helper'

RSpec.describe 'Movies Index Page' do
    before do 
        @user1 = User.create(name: "User One", email: "user1@test.com", password: "apple", password_confirmation:"apple")
        i = 1
        20.times do 
            Movie.create(title: "Movie #{i} Title", rating: rand(1..10), description: "This is a description about Movie #{i}")
            i+=1
        end 
    end 

    it 'shows all movies' do 
        visit '/'
        click_button 'Log In'

        fill_in :email, with: @user1.email
        fill_in :password, with: @user1.password

        click_button 'Log in'
    
        click_button "Find Top Rated Movies"

        expect(current_path).to eq("/users/#{@user1.id}/movies")

        expect(page).to have_content("Top Rated Movies")
        
        movie_1 = Movie.first

        click_link(movie_1.title)

        expect(current_path).to eq("/users/#{@user1.id}/movies/#{movie_1.id}")

        expect(page).to have_content(movie_1.title)
        expect(page).to have_content(movie_1.description)
        expect(page).to have_content(movie_1.rating)
    end 

    it 'user will get a message of needing to log in before they can see a user/id/movies/id show page' do
        visit movie_path(@user1.id, Movie.first.id )

        expect(current_path).to eq('/')
        expect(page).to have_content(/You must be logged in to access a user dashboard. Please log in or register./)
    end
end