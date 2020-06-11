class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users do |table|
      table.string :username
      table.string :email
      table.string :password_digest

      table.timestamps null: false
    end
  end
end