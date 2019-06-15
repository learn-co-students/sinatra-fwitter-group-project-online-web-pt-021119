require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions unless test?
    set :session_secret, "secret"
  end

  get '/' do
    erb :index
  end

  get '/error' do
    erb :"users/error"
  end
  # Helpers current_user and logged_in?
  # NO ACCESS UNLESS LOGGED IN

end
