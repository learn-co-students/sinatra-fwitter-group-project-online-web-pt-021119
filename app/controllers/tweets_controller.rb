class TweetsController < ApplicationController

    get '/tweets' do
        if logged_in?
            @tweets = Tweet.all
            erb :'/tweets/index'
        else
            redirect '/login'
        end
    end

    get '/tweets/new' do
        if logged_in?
            erb :'/tweets/new'
        else
            redirect '/login'
        end
    end

    post '/tweets' do
        if logged_in?
            if !params[:content].empty?
                current_user.tweets << Tweet.create(content: params[:content], user_id: current_user.id)
            else
                redirect '/tweets/new'
            end
        end
    end

    get '/tweets/:id' do
        redirect '/tweets' unless @tweet = Tweet.find(params[:id])
        redirect '/login' unless logged_in?
        erb :'/tweets/show'
    end
    
    get '/tweets/:id/edit' do
        redirect '/login' unless logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user
            erb :'/tweets/edit'
        end
    end

    patch '/tweets/:id' do
        redirect '/login' unless logged_in?
        @tweet = Tweet.find(params[:id])
        if @tweet.user == current_user
            if !params[:content].empty?
                @tweet.update(content: params[:content])
            else
                redirect "/tweets/#{params[:id]}/edit"
            end
        end
        redirect "/tweets/#{params[:id]}"
    end

    get '/tweets/:id/delete' do
        redirect '/login' if !logged_in?
        @tweet = Tweet.find(params[:id])
        if current_user.tweets.include?(@tweet)
            Tweet.all.delete(@tweet)
        end
        redirect '/tweets'
    end

end