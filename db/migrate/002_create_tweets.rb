class CreateTweets < ActiveRecord::Base
  def change
    create_table :tweets do |x|
      x.text :content
      x.integer :user_id
    end
  end
end
