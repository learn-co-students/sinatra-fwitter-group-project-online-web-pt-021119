class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'/users/create_user'
    else
      redirect '/tweets'
    end
  end

  post '/signup' do
    if !params["username"].empty? && !params["password"].empty? && !params["email"].empty? && !logged_in?
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    else
      redirect '/signup'
    end
  end

  get '/login' do
    erb :'/users/login'
  end

  post '/login' do
    if !params[:username].empty? && !params["password"].empty?
      user = User.find_by(username: params["username"])
      if user
        if user.authenticate(params["password"])
          session[:user_id] = user.id
          redirect '/tweets'
        end
      end
    end
    redirect '/login'
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
