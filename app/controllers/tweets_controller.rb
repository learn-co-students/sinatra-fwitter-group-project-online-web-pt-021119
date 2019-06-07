class TweetsController < ApplicationController

  get '/tweets' do #works
    @tweets = Tweet.all
    erb :'tweets/tweets'
  end

  get '/tweets/new' do #works
    erb :'tweets/new'
  end

  post '/tweets' do #works
    @tweet = Tweet.create(content: params[:content])
    redirect to "/tweets/#{@tweet.id}"
  end

  get '/tweets/:id' do #works
    @tweet = Tweet.find(params[:id])
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do #works
    @tweet = Tweet.find_by_id(params[:id])
    erb :'tweets/edit_tweet'
  end

  patch '/tweets/:id' do #works
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.update(content: params[:content])
    redirect to "/tweets"
  end

  delete '/tweets/:id' do #works
    @tweet = Tweet.find_by_id(params[:id])
    @tweet.delete
    redirect to "/tweets"
  end
end
