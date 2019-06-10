class TweetsController < ApplicationController

  # GET: /tweets
  get "/tweets" do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = @user.tweets
    else
      redirect '/login'
    end
    
    erb :"/tweets/tweets"
  end

  # GET: /tweets/new
  get "/tweets/new" do
    erb :"/tweets/new"
  end

  # POST: /tweets
  post "/tweets" do
    @tweet = Tweet.create(params[:tweet])
    redirect "/tweets/:#{tweet.id}"
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
