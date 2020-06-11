class CreateTweets < ActiveRecord::Migration[6.0]
  def change
    create_table :tweets do |t|
      t.timestamps null: true
      t.belongs_to :user, index: true
      t.integer :content
    end
  end
end
