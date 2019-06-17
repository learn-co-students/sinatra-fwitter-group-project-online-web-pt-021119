class UsersController < ApplicationController

get '/signup' do
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
		redirect "/login"
	else
		redirect "/signup_error"
	end

end

get '/login' do

  erb :"users/login"
end

post '/login' do
  @user = User.find_by(username: params[:username], password: params[:password])
  if @user != nil
    session[:user_id] = @user.id
    redirect "/tweets"
  else
    erb :error
  end
end

get '/logout' do
  session.clear
  redirect "users/login"
end
# user signup get /signup

# user post /signup + log user in + add user_id to session hash

# login form get /login

# login post /login

# logout get /logout + redirect to /login

end
