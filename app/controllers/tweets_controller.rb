class TweetsController < ApplicationController

  get '/tweets' do

    erb :'/tweets/tweets'
  end

  # get '/tweets/:id' do
  #   @user = User.find(params[:id])
  #   erb :'/tweets/show'
  # end

end
