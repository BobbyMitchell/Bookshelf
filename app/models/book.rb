class Book < ApplicationRecord
  validates :title, :author, presence: true
  has_many :comments, dependent: :destroy
end
