class UsersController < ApplicationController



  get '/signup' do
    # if !is_logged_in?
    erb :'/users/signup'
  end

  post "/signup" do
    redirect '/tweets' if is_logged_in?
    if params[:username] == "" || params[:email] == "" || params[:password] == ""

      redirect '/signup'
    else
      user = User.create(params)
      session[:user_id] = user.id
      redirect '/tweets'
    end
  end
end
