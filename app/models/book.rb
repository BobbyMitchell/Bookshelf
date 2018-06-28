class Book < ApplicationRecord
  validates :title, :author, presence: true
  has_many :comments, dependent: :destroy
  validates :rating, inclusion: {in: [1,2,3,4,5], allow_nill: false }
end
