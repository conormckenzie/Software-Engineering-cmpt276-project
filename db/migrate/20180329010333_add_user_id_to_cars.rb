class AddUserIdToCars < ActiveRecord::Migration[5.1]
  def change
    add_reference :cars, :user_id, foreign_key: true
  end
end
