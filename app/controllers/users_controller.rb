class UsersController < ApplicationController
  use Rack::Flash

  get "/signup" do
    if logged_in?
      redirect '/tweets'
    end

    erb :"/users/create_user"
  end

  post '/signup' do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      flash[:notice] = "Don't leave anything empty."
      redirect '/signup'
    else
      @user = User.create(:username => params[:username], :email => params[:email], :password => params[:password])
      session[:user_id] = @user.id
      redirect '/tweets'
    end
  end

  get '/login' do
    if !logged_in?
      flash[:notice] = "You need to be logged in to access this page."
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
      flash[:notice] = "Something went wrong. Try again?"
      redirect to '/login'
    end
  end

  get '/logout' do
    session.clear
    redirect "/login"
  end

  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :"/users/show"
  end

  delete "/users/:slug/delete" do
    @user = User.find_by_slug(params[:slug])
    @user.destroy
    redirect "/"
  end
end
