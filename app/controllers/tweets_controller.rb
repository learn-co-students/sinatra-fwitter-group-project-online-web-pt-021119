class TweetsController < ApplicationController

  get '/tweets' do
    erb :'tweets/tweets'
  end

  get '/tweets/new' do
    erb :'tweets/create_tweet'
  end

  post '/tweets' do

  end

  get '/tweets/:id' do
    erb :'tweets/show_tweet'
  end

  get '/tweets/:id/edit' do
    erb :'tweets/edit_tweet'
  end

end
