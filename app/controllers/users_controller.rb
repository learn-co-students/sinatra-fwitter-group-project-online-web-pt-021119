class UsersController < ApplicationController
  get '/signup' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'users/signup'
    end
  end

  post '/signup' do
    if params[:email] == "" || params[:password] == "" || params[:username] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if logged_in?
      redirect '/tweets'
    else
      erb :'/users/login'
    end
  end

  post '/login' do
    @user = User.find_by(:username => params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect "/tweets"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session.clear
    redirect '/login'
  end

  get '/users' do
    erb :'users/index'
  end

  get "/users/:id" do
    @user = User.find_by_slug(params[:id])
    erb :'users/show'
  end
end
