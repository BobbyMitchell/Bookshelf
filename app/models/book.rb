class Book < ApplicationRecord
  has_many :user_books
  has_many :users, through: :user_books
  validates :title, :author, presence: true
  has_many :comments, dependent: :destroy
  validates :rating, inclusion: {in: [1,2,3,4,5], allow_nill: false }
end
