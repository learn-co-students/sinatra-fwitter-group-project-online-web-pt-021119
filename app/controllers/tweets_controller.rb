require 'pry'
class TweetsController < ApplicationController

  get '/tweets' do
    if !logged_in?
      redirect '/login'
    else
      @tweets = Tweet.all
      erb :'tweets/index'
    end
  end

  get '/tweets/new' do
    if !logged_in?
      redirect '/login'
    else
      erb :'tweets/new'
    end
  end

  post '/tweets' do
  if !logged_in?
    redirect '/login'
  else
    if params[:content].empty?
      redirect '/tweets/new'
    else
      @tweet = Tweet.create(:content => params[:content], :user_id => current_user.id)
    end
      redirect "tweets/#{@tweet.id}"
    end
  end

  get '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      erb :'tweets/show'
    end
  end

  get '/tweets/:id/edit' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
        if @tweet && @tweet.user == current_user
          erb :'tweets/edit'
        else
          redirect "/tweets"
        end
    end
  end

  patch '/tweets/:id' do
    if !logged_in?
      redirect '/login'
    else
      @tweet = Tweet.find_by_id(params[:id])
      if params[:content].empty?
        redirect to "/tweets/#{@tweet.id}/edit"
      else
          if @tweet && @tweet.user == current_user
            @tweet.update(:content => params[:content])
          end
      end
      redirect "/tweets/#{@tweet.id}/edit"
    end
  end

  delete '/tweets/:id/delete' do
    @tweet = Tweet.find_by_id(params[:id])
      if !logged_in?
        redirect '/login'
      else
        if @tweet.user == current_user
          @tweet.delete
        end
      redirect '/tweets'
      end
  end


end
