class UsersController < ApplicationController
  get '/signup' do
    redirect '/tweets' if session[:user_id] != nil
    erb :'/users/create_user'
  end

  post '/signup' do
    redirect '/signup' if params[:username].empty? || params[:email].empty? || params[:password].empty?
    @user = User.create(params)
    #binding.pry
    if @user.save
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    #binding.pry
    if session[:user_id] != nil
      @user = current_user
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(username: params[:username])
    #binding.pry
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

  get '/logout' do
    session.clear if session[:user_id] != nil
    redirect '/login'
  end

  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
end
