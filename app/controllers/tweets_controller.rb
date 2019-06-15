class TweetsController < ApplicationController

  get '/tweets' do
    if Helpers.logged_in?(session)
      @tweets = Tweet.all
      erb :'tweets/tweets'
    else
      redirect '/login'
    end
  end

  get '/tweets/new' do
    if Helpers.logged_in?(session)
      erb :'/tweets/new'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id' do
    if Helpers.logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      erb :'/tweets/show_tweet'
    else
      redirect '/login'
    end
  end

  get '/tweets/:id/edit' do
    if Helpers.logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == Helpers.current_user
        erb :'/tweets/edit_tweet'
      else
        redirect '/tweets'
      end
    else
      redirect '/login'
    end
  end

  post '/tweets' do
    # some code collecting data from create tweet form
    if Helpers.logged_in?(session)
      if params[:content] = ""
        redirect '/tweets/new'
      else
        @tweet = Helpers.current_user.tweets.create(content: params[:content])
        if @tweet.save
          redirect "/tweets/#{tweet.id}"
        else
          redirect "/tweets/new"
        end
      end
    else
      redirect '/login'
    end
  end

  patch '/tweet/:id' do
    # some code collecting data from edit tweet form
    if Helpers.logged_in?
      if params[:content] == ""
        redirect "/tweets/#{params[:id]}/edit"
      else
        @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == Helpers.current_user
          if @tweet.update(content: params[:content])
            redirect "/tweets/#{@tweet.id}"
          else
            redirect "/tweets/#{tweet.id}/edit"
          end
        else
          redirect '/tweets'
        end
      end
    else
      redirect '/login'
    end
  end

  delete '/tweets/:id/delete' do
    if Helpers.logged_in?
      @tweet = Tweet.find_by_id(params[:id])
      if @tweet && @tweet.user == Helpers.current_user
        @tweet.delete
      end
      redirect '/tweets'
    else
      redirect '/login'
    end
  end

end
