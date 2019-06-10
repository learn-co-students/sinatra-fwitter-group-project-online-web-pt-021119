class TweetsController < ApplicationController
  use Rack::Flash

  # GET: /tweets
  get "/tweets" do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all
    else
      redirect '/login'
    end

    erb :"/tweets/tweets"
  end

  # GET: /tweets/new
  get "/tweets/new" do
    @user = User.find(session[:user_id])

    erb :"/tweets/new"
  end

  # POST: /tweets
  post "/tweets" do


    user = User.find_by(session[:user_id])
    tweet = Tweet.create(params)
    tweet.user = user
    tweet.save
    # redirect "/tweets/:#{tweet.id}"
    redirect "/tweets"
  end

  # GET: /tweets/5
  get "/tweets/:id" do
    erb :"/tweets/show_tweet"
  end

  # GET: /tweets/5/edit
  get "/tweets/:id/edit" do
    erb :"/tweets/edit_tweet"
  end

  # PATCH: /tweets/5
  patch "/tweets/:id" do
    redirect "/tweets/:id"
  end

  # DELETE: /tweets/5/delete
  delete "/tweets/:id/delete" do
    redirect "/tweets"
  end
end
