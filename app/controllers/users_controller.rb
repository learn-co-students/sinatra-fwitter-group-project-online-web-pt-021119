class UsersController < ApplicationController

get '/signup' do
  erb :"users/create_user"
end

post '/signup' do
  erb :"tweets/tweets"
end

get '/login' do
  erb :"users/login"
end

post '/login' do

end

get '/logout' do
  redirect "users/login"
end
# user signup get /signup

# user post /signup + log user in + add user_id to session hash

# login form get /login

# login post /login

# logout get /logout + redirect to /login

end
