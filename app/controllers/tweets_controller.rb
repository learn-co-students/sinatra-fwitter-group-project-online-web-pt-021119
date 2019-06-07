class TweetsController < ApplicationController

	get '/tweets' do
		if logged_in?
			@user = current_user
			@tweets = Tweet.all
			erb :tweets
		else
			redirect '/login'
		end
	end

	get '/tweets/new' do
		if logged_in?
			erb :tweet_new
		else
			redirect '/login'
		end
	end

	post '/tweets' do
		if !params[:content].empty?
			tweet = Tweet.create(params)
			current_user.tweets << tweet
			redirect "/tweets/#{tweet.id}"
		else
			redirect '/tweets/new'
		end
	end

	get '/tweets/:id' do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :tweet_show
		else
			redirect '/login'
		end
	end

	get '/tweets/:id/edit' do
		if logged_in?
			@tweet = Tweet.find(params[:id])
			erb :tweet_edit
		else
			redirect '/login'
		end
	end

	patch '/tweets/:id' do
		tweet = Tweet.find(params[:id])
		if !params[:content].empty?
			tweet.content = params[:content]
			tweet.save
			redirect "/tweets/#{tweet.id}"
		else
			redirect "/tweets/#{tweet.id}/edit"
		end
	end

	delete '/tweets/:id' do
		tweet = Tweet.find(params[:id])
		if current_user.tweets.include?(tweet)
			Tweet.find(params[:id]).destroy
		else
			redirect "/tweets"
		end
	end


end
