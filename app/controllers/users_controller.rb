class UsersController < ApplicationController

    get '/signup' do 
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/signup'
        end

    end

    post '/signup' do
        if params[:username] == "" || params[:email] == "" || params[:password] == ""
            redirect '/signup'
        end
        @user = User.create(username: params[:username], email: params[:email], password: params[:password])
        session[:user_id] = @user.id
        redirect '/tweets'
    end

    get '/login' do
        erb :'users/login'
    end

    post '/login' do
        # binding.pry
        @user = User.find_by(:username => params[:username])
        if @user != nil && @user.password == params[:password]
            session[:user_id] = @user.id
            redirect '/tweets'
        end
        redirect '/login'
    end

end
