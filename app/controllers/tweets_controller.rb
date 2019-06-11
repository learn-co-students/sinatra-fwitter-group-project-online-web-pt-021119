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
      user = User.find_by_id(session[:user_id])
      tweet = Tweet.create(params)
      tweet.user = user
      binding.pry
      tweet.save
      # redirect "/tweets/:#{tweet.id}"
      redirect "/tweets"
    end
  end

  # GET: /tweets/5
  get "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    erb :"/tweets/show_tweet"
  end

  # GET: /tweets/5/edit
  get "/tweets/:id/edit" do
    @tweet = Tweet.find(params[:id])
    @user = @tweet.user
    erb :"/tweets/edit_tweet"
  end

  # PATCH: /tweets/5
  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if @tweet.update(params)
      redirect "/tweets/:id"
    else
      flash[:notice] = "Something went wrong. Try again?"
      redirect "/tweets/:id/edit"
    end
  end

  # DELETE: /tweets/5/delete
  delete "/tweets/:id/delete" do
    @tweet = Tweet.find(params[:id])
    @tweet.destroy
    redirect "/tweets"
  end
end
