class User < ActiveRecord::Base
  has_secure_password
  has_many :tweets

  def slug
    username.downcase.gsub(" ","-")
  end
  # https://github.com/learn-co-students/playlister-sinatra-dumbo-web-071618/blob/solution/app/models/artist.rb

end
