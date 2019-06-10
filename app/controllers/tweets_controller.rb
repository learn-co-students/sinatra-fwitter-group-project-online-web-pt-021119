class TweetsController < ApplicationController

  get '/tweets' do #works
    if logged_in?
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect to '/login'
    end
  end

  get '/tweets/new' do #works
    if logged_in?
      erb :'tweets/new'
    else
      redirect to '/login'
    end
  end

  post '/tweets' do #works
    if logged_in?
      if params[:content] == ""
        redirect to '/tweets/new'
      else
        @tweet = current_user.Tweet.create(content: params[:content])
        redirect to "/tweets/#{@tweet.id}"
      end
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id' do #works
    if logged_in?
      @tweet = Tweet.find(params[:id])
      erb :'tweets/show_tweet'
    else
      redirect to '/login'
    end
  end

  get '/tweets/:id/edit' do #works
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        erb :'tweets/edit_tweet'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end

  patch '/tweets/:id' do #works
    if logged_in?
      if params[:content] == ""
        redirect to "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == curent_user
          @tweet.update(content: params[:content])
          redirect to "/tweets"
        else
          redirect to '/tweets'
        end
      end
    else
      redirect to '/login'
    end
  end

  delete '/tweets/:id' do #works
    if logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == current_user
        @tweet.delete
        redirect to '/tweets'
      else
        redirect to '/tweets'
      end
    else
      redirect to '/login'
    end
  end
end
