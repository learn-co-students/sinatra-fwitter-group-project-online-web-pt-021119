class UsersController < ApplicationController

    get '/signup' do 
        erb :'users/signup'
    end

    # post '/signup' do
    #     if params[:username] == "" || params[:email] == "" || params[:password] == ""
    #         redirect '/signup'
    #     end
    #     # binding.pry
    #     @user = User.create(username: params[:username], email: params[:email], password: params[:password])
    #     session[:user_id] = @user.id
    #     redirect :"/tweets"
    # end

end
