require 'rack-flash'

class UsersController < ApplicationController
  use Rack::Flash

  get '/signup' do
    erb :'/users/create_user'
  end

  post '/signup' do
    params.each do |k, v|
      if params[k].nil?
        flash[:message] = "Please fill out #{k} field."
      end
    end
    @user = User.create(username: params[:username], email: params[:email], password: params[:password])

=begin
    if params[:username].nil?
      flash[:message] = "Please enter a username."
    elsif params[:email].nil?
      flash[:message] = "Please enter an email."
    elsif params[:password].nil?
      flash[:message] = "Please enter a password."
    else
      @user = User.create(username: params[:username], password: params[:password])
    end
=end
  end

end
