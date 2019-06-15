class TweetsController < ApplicationController

  get '/tweets/new' do
    erb :'/tweets/new'
  end

  get '/tweets/:id' do
    @user = User.find_by(id: session[:user_id])
    erb :'/tweets/tweets'
  end

  get '/tweets/:id/edit' do
    erb :'/tweets/edit'
  end

  post '/tweets' do
    # some code collecting data from create tweet form

    redirect to "/tweets/#{tweet.id}"
  end

  patch '/tweet/:id' do
    # some code collecting data from edit tweet form

    redirect to "/tweets/#{tweet.id}"
  end

end
