require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "_=fw1tt4h=_"
  end

  def logged_in?
    true if !session[:user_id].nil?
  end

  def current_user
    User.find(session[:user_id])
  end


  get '/' do
    erb :index
  end

end
