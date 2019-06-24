class UsersController < ApplicationController

    get '/signup' do
        if logged_in?
            redirect to '/tweets'
        else
            erb :'/users/new'
        end
    end

    post '/signup' do
        if params[:username].empty? || params[:email].empty? || params[:password].empty?
            redirect to '/signup'
        else
            @user = User.create(params)
            session[:user_id] = @user.id
            redirect to '/tweets'
        end
    end

    get '/login' do
        if logged_in?
            redirect '/tweets'
        else
            erb :'/users/login'
        end
    end

    # refactor to be more readable. use !params.empty? && and have only one redirect login, with no else
    post '/login' do
        if params[:username].empty? || params[:password].empty?
            redirect '/login'
        else
            user = User.find_by(username: params[:username])
            if user
                if user.authenticate(params[:password])
                    session[:user_id] = user.id
                    redirect '/tweets'
                end
            end
        end
        redirect '/login'
    end

    get '/logout' do
        if logged_in?
            session.clear
        end
            redirect '/login'
    end

    get '/users/:slug' do
        @user = User.find_by_slug(params[:slug])
        if @user
            erb :'/users/show'
        else
            redirect '/tweets'
        end
    end

end