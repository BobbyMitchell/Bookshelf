class Book < ApplicationRecord
  validates :title, :author, :rating, presence: true
end
