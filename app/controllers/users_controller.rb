class UsersController < ApplicationController

get '/signup' do
  redirect "/tweets" if Helpers.is_logged_in?(session)
  erb :"users/create_user"
end

post '/signup' do
  if params[:username].empty?
    redirect '/signup_error'
  elsif params[:email].empty?
    redirect '/signup_error'
  end
  @user = User.new(username: params[:username], email: params[:email], password: params[:password])
  if @user.save
    session[:user_id] = @user.id
    redirect "/tweets"
	else
    redirect "/signup_error"
	end
  redirect "/signup_error"
end

get '/login' do

  erb :"users/login"
end

post '/login' do
  @user = User.find_by(username: params[:username])
  if @user && @user.authenticate(params[:password])
    session[:user_id] = @user.id
    redirect "/tweets"
  else
    erb :"users/error"
  end
end

get "/users/:username" do
  @user = User.find_by(username: params[:username])
  erb :"tweets/tweets"  
end

get '/logout' do

  erb :"users/logout"
end

post '/logout' do
  session.clear
  redirect "/login"
end
# user signup get /signup

# user post /signup + log user in + add user_id to session hash

# login form get /login

# login post /login

# logout get /logout + redirect to /login

end
