require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end

  get '/' do 
    erb :index 
  end

  get '/signup' do 
    erb :signup
  end

  post '/signup' do
    binding.pry
    @user = User.create(name: params[:username], email: params[:email], password: params[:password])

    redirect :"/tweets"
  end

end
