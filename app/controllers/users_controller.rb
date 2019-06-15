require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    if !session[:user_id]
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(username: params["username"], email: params["email"], password: params["password"])
      @user.save
      session[:user_id] = @user.id
      redirect "/tweets/#{@user.id}"
    end
  end

  get '/login' do
    if !session[:user_id]
      erb :'/users/login'
    else
      @user = User.find_by(id: session[:user_id])
      redirect "/tweets/#{@user.id}"
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    session[:user_id] = @user.id
    redirect "/tweets/#{@user.id}"
  end

  get '/logout' do
    if session[:user_id]
      session.clear
      redirect '/'
    else
      redirect '/login'
    end
  end

end
