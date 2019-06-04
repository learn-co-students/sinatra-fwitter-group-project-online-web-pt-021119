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
    user = current_user
    user.tweets << Tweet.create(params[:tweet])

    redirect "/tweets/#{user.tweets.last.id}"
  end

  get '/tweets/new' do
    if logged_in?
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
      @tweet = Tweet.find(params[:id])
    erb :'/tweets/show_tweet'
  end

end
