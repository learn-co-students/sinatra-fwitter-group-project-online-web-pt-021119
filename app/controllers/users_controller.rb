class UsersController < ApplicationController

  get '/signup' do
    erb :'users/create_user'
  end

  post '/signup' do

  end

  get '/login' do
    erb :'users/login'
  end

  get '/tweets/:id/edit' do
    erb :'tweets/edit_tweet'
  end

  get '/logout' do
    erb :index
  end

end
