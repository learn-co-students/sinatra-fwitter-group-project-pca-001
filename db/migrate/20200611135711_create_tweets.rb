class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.string :content
      t.belongs_to :user
      t.timestamps null: false
    end
  end
end
