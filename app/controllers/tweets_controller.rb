class TweetsController < ApplicationController

  get '/tweets' do
    if is_logged_in?
      @tweets = Tweet.all
      @user = current_user
      erb :"/tweets/tweets"
    else redirect to '/login'
    end
  end

  get '/tweets/new' do
    if !is_logged_in?
      redirect to '/login'
    end
    erb :"/tweets/create_tweet"
  end

  post '/tweets' do
    user = current_user
    if params["content"].empty?
      redirect to '/tweets/new'
    end
    tweet = Tweet.create(:content => params["content"], :user_id => user.id)

    redirect to '/tweets'
  end

  get '/tweets/:id' do
    if !is_logged_in?
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    erb :"tweets/show_tweet"
  end

  get '/tweets/:id/edit' do
    if !is_logged_in?()
      redirect to '/login'
    end
    @tweet = Tweet.find(params[:id])
    if current_user.id != @tweet.user_id
      redirect to '/tweets'
    end
    erb :"tweets/edit_tweet"
  end

  patch '/tweets/:id' do
    tweet = Tweet.find(params[:id])
    if params["content"].empty?
      redirect to "/tweets/#{params[:id]}/edit"
    end
    tweet.update(:content => params["content"])
    tweet.save

    redirect to "/tweets/#{tweet.id}"
  end

  delete '/tweets/:id/delete' do
    if is_logged_in?
      @tweet = Tweet.find(params[:id])
      if current_user == @tweet.user
        @tweet.delete
      end
      redirect to '/tweets'
    else
      redirect to '/login'
    end
  end

end
