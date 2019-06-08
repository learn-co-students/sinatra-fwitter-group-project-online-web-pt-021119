class UsersController < ApplicationController

  def logged_in?
    true if !params[:user_id].nil?
  end

  def current_user
    User.find(params[:user_id])
  end

  get "/signup" do
    erb :"/users/create_user"
  end

  post '/signup' do
    user = User.new(:username => params[:username], :password => params[:password])

    if user.save
      redirect "/login"
    else
      redirect "/signup"
    end
  end

  get '/login' do
    erb :"/users/login"
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/users/#{user.id}"
    else
      redirect "/login"
    end
  end

  get '/logout' do
    session[:user_id].clear
    redirect "/"
  end

  # GET: /users/5
  get "/users/:id" do
    @user = User.find(params[:id])
    erb :"/users/show"
  end

  # DELETE: /users/5/delete
  delete "/users/:id/delete" do
    @user = User.find(params[:id])
    @user.destroy
    redirect "/"
  end
end
