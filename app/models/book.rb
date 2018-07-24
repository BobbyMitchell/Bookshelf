class Book < ApplicationRecord


  has_many :user_books
  accepts_nested_attributes_for :user_books, allow_destroy: true
  has_many :users, through: :user_books


  validates :title, :author, presence: true
  has_many :comments, dependent: :destroy
  validates :rating, inclusion: {in: [1,2,3,4,5], allow_nill: false }
end

# <%= simple_form_for [@book, @user_book], url: edit_book_user_book_path(@book,  @user_book), method: :patch do |f| %>
# <%= f.input :have_or_want,  url: book_user_book_path(@book, @user_book), method: :patch %>
# <%= f.submit "Submit" %>
