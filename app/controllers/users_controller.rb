class UsersController < ApplicationController



  get '/signup' do

    erb :'/users/signup'
  end

  post "/signup" do
    if params[:username] == "" || params[:email] == "" || params[:password] == ""
      redirect '/failure'
    else
      @user = User.create(username: params[:username], password: params[:password])
      redirect '/tweets'
    end
  end


end
