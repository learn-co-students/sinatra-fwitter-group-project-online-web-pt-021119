class UsersController < ApplicationController

  get '/signup' do

    erb :'/users/create_user'
  end

  post '/signup' do
    binding.pry
    if !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:user][:email].empty?
      user = User.create(params)
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end
end
