class CreateUserBooks < ActiveRecord::Migration[5.1]
  def change
    create_table :user_books do |t|
      t.belongs_to :user, index: true
      t.belongs_to :book, index: true
      t.boolean :have_or_want
      t.timestamps
    end
  end
end
