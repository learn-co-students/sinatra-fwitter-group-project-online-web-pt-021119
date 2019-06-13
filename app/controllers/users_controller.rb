class UsersController < ApplicationController

  get '/signup' do
    if !logged_in?
      erb :'users/create_user'
    else
      redirect to '/tweets/tweets'
    end
  end

  post '/signup' do
    if params[:username].empty? || params[:email].empty? || params[:password].empty?
       redirect to '/signup'
    else
      #binding.pry
      user = User.create(params)
      session[:user_id] = user.id
      redirect to '/tweets'
   end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
      #binding.pry
    else
      redirect '/tweets'
    end
  end


  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect to '/tweets'
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    if logged_in?
      session.destroy
      redirect to '/login'
    else
      redirect to '/tweets'
    end
  end



end
