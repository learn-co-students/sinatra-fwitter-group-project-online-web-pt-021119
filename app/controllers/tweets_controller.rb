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
      tweet.save
      # redirect "/tweets/:#{tweet.id}"
      redirect "/tweets"
    end
  end

  # GET: /tweets/5
  get "/tweets/:id" do
    if logged_in?
      @tweet = Tweet.find(params[:id])
      @user = @tweet.user
      erb :"/tweets/show_tweet"
    else
      flash[:notice] = "You need to be logged in to access this page."
      redirect '/login'
    end
  end

  # GET: /tweets/5/edit
  get "/tweets/:id/edit" do
    if logged_in?
      if Tweet.find(params[:id]).user.id == session[:user_id]
        @tweet = Tweet.find(params[:id])
        @user = @tweet.user
        erb :"/tweets/edit_tweet"
      else
        flash[:notice] = "You may only edit your own tweets."
        redirect '/tweets'
      end
    else
      flash[:notice] = "You need to be logged in to access this page."
      redirect '/login'
    end
  end

  # PATCH: /tweets/5
  patch "/tweets/:id" do
    @tweet = Tweet.find(params[:id])
    if @tweet.update(content: params[:content])
      redirect "/tweets/#{@tweet.id}"
    else
      flash[:notice] = "Something went wrong. Try again?"
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  # DELETE: /tweets/5/delete
  delete "/tweets/:id/delete" do
    if Tweet.find(params[:id]).user.id == session[:user_id]
      @tweet = Tweet.find(params[:id])
      @tweet.destroy
      redirect "/tweets"
    else
      flash[:notice] = "You may only delete your own tweets."
      redirect '/tweets'
    end
  end
end
