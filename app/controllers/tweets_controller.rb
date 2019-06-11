class TweetsController < ApplicationController

    get '/tweets' do
        erb :'tweets/tweets'
      else
        redirect to '/login'
      end
    end
