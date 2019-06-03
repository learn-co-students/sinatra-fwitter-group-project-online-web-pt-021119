class UsersController < ApplicationController

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    if !params[:user][:username].empty? && !params[:user][:password].empty? && !params[:user][:email].empty?
      user = User.create(params[:user])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    if !params[:user][:username].empty? && !params[:user][:password].empty?
      user = User.find_by(username: params[:username])
      if user
        session[:user_id] = user.id
        redirect "/tweets"
      else
        redirect '/signup'
      end
    else
      redirect '/login'
    end
  end

  get '/users/:id' do
    @user = User.find(params[:id])
    erb :'/users/show'
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end
end
