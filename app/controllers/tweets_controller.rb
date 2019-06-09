class TweetsController < ApplicationController
  get '/tweets/new' do
    if session[:user_id] != nil
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  post '/tweets/new' do
    redirect '/tweets/new' if session[:user_id] != nil
    redirect '/login'
  end

  get '/tweets' do
    #binding.pry
    if session[:user_id] != nil
      @user = current_user
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    @user = User.find(session[:user_id])
    redirect '/tweets/new' if params[:tweet][:content].empty?
    @user.tweets << Tweet.new(params[:tweet])
    redirect "/users/#{@user.slug}"
  end

  get '/tweets/:id/edit' do
    if session[:user_id] != nil
      @tweet = Tweet.find(params[:id])
      erb :'/tweets/edit_tweet' if @tweet.user.id == session[:user_id]
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if session[:user_id] != nil
      @tweet = Tweet.find(params[:id])
      #binding.pry
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  post '/tweets/:id' do
    redirect "/tweets/#{params[:id]}/edit"
  end

  patch '/tweets/:id' do
    redirect "tweets/#{params[:id]}/edit" if params[:tweet][:content].empty?
    @tweet = Tweet.find(params[:id])
    @tweet.update(params[:tweet])
    redirect "/tweets/#{@tweet.id}"
  end

  delete '/tweets/:id' do
    if session[:user_id] != nil
      @tweet = Tweet.find(params[:id])
      @tweet.destroy if @tweet.user.id == session[:user_id]
    else
      redirect '/login'
    end
  end

end
