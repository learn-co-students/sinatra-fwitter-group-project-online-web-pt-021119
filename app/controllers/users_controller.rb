class UsersController < ApplicationController

  get "/signup" do
    if logged_in?
      redirect '/tweets'
    end

    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      erb :'users/login'
    else
      redirect '/tweets'
    end
  end

  post '/login' do
    user = User.find_by(:username => params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect "/tweets"
    else
      redirect to '/signup'
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
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
