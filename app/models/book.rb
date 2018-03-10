class Book < ApplicationRecord
  validates :title,  presence: true, length: { maximum: 50 }
  validates :year, presence: true, length: { maximum: 10 }
  validates :isbn, presence: true, length: { maximum: 20 }
end
