class UsersController < ApplicationController

	get '/signup' do
		if logged_in?
			redirect '/tweets'
		else
			erb :signup
		end
	end

	post '/signup' do
		if params["username"].empty? || params["email"].empty? || params["password"].empty?
			redirect '/signup'
		else
			session[:user_id]=User.create(params).id
			redirect '/tweets'
		end
	end

	get '/login' do
		logged_in? ? (redirect '/tweets') : (erb :login)
	end

	post '/login' do
		user = User.find_by username: params[:username]
		if user && user.authenticate(params[:password])
			session[:user_id] = user.id
			redirect '/tweets'
		else
			erb :failure
		end
	end

	get '/logout' do
		logout
		redirect '/login'
	end

	get "/users/:slug" do
		@user = User.find_by_slug(params[:slug])
		# if logged_in?
			# @user = current_user
			@tweets = @user.tweets

		# else
			# redirect '/login'
		# end
		erb :tweets_user
	end

end
