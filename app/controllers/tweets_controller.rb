class TweetsController < ApplicationController
  use Rack::Flash

  # GET: /tweets
  get "/tweets" do
    if logged_in?
      @user = User.find(session[:user_id])
      @tweets = Tweet.all.reverse
    else
      flash[:notice] = "You need to be logged in to access this page."
      redirect '/login'
    end

    erb :"/tweets/tweets"
  end

  # GET: /tweets/new
  get "/tweets/new" do
    if logged_in?
      @user = User.find(session[:user_id])
    else
      flash[:notice] = "You need to be logged in to access this page."
      redirect '/login'
    end

    erb :"/tweets/new"
  end

  # POST: /tweets
  post "/tweets" do
    if params[:content].empty?
      flash[:notice] = "Can't submit an empty tweet!"
      redirect "/tweets/new"
    else
      user = User.find_by(session[:user_id])
      tweet = Tweet.create(params)
      tweet.user = user
      tweet.save
      # redirect "/tweets/:#{tweet.id}"
      redirect "/tweets"
    end
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
