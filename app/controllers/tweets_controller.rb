class TweetsController < ApplicationController

  get '/tweets' do
  if logged_in?
    erb :'tweets/tweets'
  else
    redirect to '/login'
  end
end

  # get '/tweets/:id' do
  #   @user = User.find(params[:id])
  #   erb :'/tweets/show'
  # end

end
