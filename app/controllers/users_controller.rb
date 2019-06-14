require 'rack-flash'

class UsersController < ApplicationController
  #use Rack::Flash

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    params.each do |k, v|
      if params[k].nil?

      end
    end
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])

    @user.save
    redirect "/tweets"
  end

  get '/login' do
    if session[:user_id].nil?
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    sessions[:user_id] = @user.id
    redirect '/tweets/tweets'
  end

  get '/logout' do
    session.clear
    redirect '/'
  end

end
