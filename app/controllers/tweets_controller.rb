class TweetsController < ApplicationController

get "/tweets/new" do
  erb :"tweets/new"
end

post "/tweets" do
  redirect "/tweets/#{@tweet.id}"
end

get "/tweets" do
  erb :"tweets/tweets"
end

get "/tweets/:id" do
  erb :"tweets/show_tweet"
end

get "/tweets/:id/edit" do
  erb :"tweets/edit_tweet"
end

post "/tweets/:id" do
  redirect "/tweets/#{@tweet.id}"
end

delete "/tweets/:id" do
  redirect "/tweets"
end
#create tweet form get /tweets/new

#process form submission post /tweets

#show tweet get /tweets/:id  + edit link + delete link

#edit tweet get /tweets/:id/edit

#submit edit post /tweets/:id

#delete via post /tweets/:id/delete

end
