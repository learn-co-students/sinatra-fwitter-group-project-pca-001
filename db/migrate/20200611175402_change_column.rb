class ChangeColumn < ActiveRecord::Migration[6.0]
  def change
    change_column :tweets, :content, :string
  end
end
