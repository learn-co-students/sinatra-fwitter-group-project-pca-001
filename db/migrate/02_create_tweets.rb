class CreateTweets < ActiveRecord::Migration[4.2]
  def change
    create_table :tweets do |table|
      table.text :content
      table.integer :user_id

      table.timestamps null: false
    end
  end
end