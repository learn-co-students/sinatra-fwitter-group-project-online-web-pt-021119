class CreateUsers < ActiveRecord::Base

  def change
    create_table :users do |x|
      x.string :username
      x.text :email
      x.string :password_digest

      x.timestamps
    end
  end
end
