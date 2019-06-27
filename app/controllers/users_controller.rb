class UsersController < ApplicationController

    get '/users/:slug' do
        @user = User.all.find {|u| u.slug == params["slug"]}
        # binding.pry
        erb :'users/tweets'
    end

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
        if logged_in?
            redirect to '/tweets'
        else
            erb :'users/login'
        end
    end

    post '/login' do

        user = User.find_by(:username => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/tweets"
        else
            redirect '/login'
        end
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect to '/login'
        else
            redirect to '/'
        end
    end



end
