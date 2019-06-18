class TweetsController < ApplicationController

get "/tweets/new" do

  erb :"tweets/new"
end

post "/tweets" do
  @user = User.find_by(params[:id])
  @tweet = Tweet.create(content: params[:content], user_id: @user.id)
  redirect "/tweets/#{@tweet.id}"
end

get "/tweets" do
  redirect "/login" if !Helpers.is_logged_in?(session)
  @user = User.find_by(params[:id])
  @tweets = Tweet.where(user_id: session[:user_id])
  erb :"tweets/tweets"
end

get "/tweets/:id" do
  redirect "/login" if !Helpers.is_logged_in?(session)
  @tweet = Tweet.find_by(id: params[:id])
  if session[:user_id] == Helpers.current_user(session).id
    erb :"tweets/show_tweet"
  else
    redirect "/tweets"
  end
end

get "/tweets/:id/edit" do
  redirect "/login" if !Helpers.is_logged_in?(session)
  @tweet = Tweet.find_by_id(params[:id])
  erb :"tweets/edit_tweet"
end

patch "/tweets/:id" do
  @tweet = Tweet.find_by_id(params[:id])
  @tweet.content = params[:content]
  @tweet.save
  redirect "/tweets/#{@tweet.id}"
end

delete "/tweets/:id" do
  @tweet = Tweet.find_by_id(params[:id])
  @tweet.delete
  redirect "/tweets"
end
#create tweet form get /tweets/new

#process form submission post /tweets

#show tweet get /tweets/:id  + edit link + delete link

#edit tweet get /tweets/:id/edit

#submit edit post /tweets/:id

#delete via post /tweets/:id/delete

end
