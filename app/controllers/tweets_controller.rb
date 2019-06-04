class TweetsController < ApplicationController

  get '/tweets' do
  if logged_in?
    @tweets = Tweet.all
    erb :'/tweets/tweets'
  else
    redirect to '/login'
  end
end

  # get '/tweets/:id' do
  #   @user = User.find(params[:id])
  #   erb :'/tweets/show'
  # end

end
