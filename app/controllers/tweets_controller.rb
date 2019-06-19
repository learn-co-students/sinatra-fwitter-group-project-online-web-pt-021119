class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      erb :'/tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if is_logged_in?
      session[:user_id] = user.id
      erb :'tweets/new'
    else
      redirect '/login'
    end
  end
end
