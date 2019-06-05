class TweetsController < ApplicationController

  get '/tweets' do
    if logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do
    if params[:tweet][:content].empty?
      redirect '/tweets/new'
    else
      user = current_user
      user.tweets << Tweet.create(params[:tweet])
      redirect "/tweets/#{user.tweets.last.id}"
    end
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  patch '/tweets/:id/edit' do
    redirect "/tweets/#{params[:id]}/edit" if params[:tweet][:content].empty?
    tweet = Tweet.find(params[:id])
    tweet.update(params[:tweet])
    redirect "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    redirect '/tweets' if !logged_in?
    @tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(@tweet)
      Tweet.find(params[:id]).destroy
      erb :'/tweets/edit_tweet'
    end
      redirect '/tweets'
  end

  get '/tweets/:id/edit' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    if current_user.tweets.include?(@tweet)
      erb :'/tweets/edit_tweet'
    else
      redirect '/tweets'
    end
  end

  get '/tweets/:id' do
    redirect '/login' if !logged_in?
    @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

end
