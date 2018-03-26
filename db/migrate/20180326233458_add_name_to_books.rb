class AddNameToBooks < ActiveRecord::Migration[5.1]
  def change
    add_column :books, :price, :string
    add_column :books, :course_number, :string
    add_column :books, :image, :string
    add_column :books, :author, :string
  end
end
