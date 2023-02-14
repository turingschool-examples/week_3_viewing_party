class MoviesController < ApplicationController
    def index 
        @user = User.find(params[:id])
        require 'pry'; binding.pry
        @movies = Movie.all
    end 

    def show 
        @user = User.find(params[:user_id])
        @movie = Movie.find(params[:id])
    end 
end 