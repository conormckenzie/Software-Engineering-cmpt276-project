class Book < ApplicationRecord
  mount_uploader :image, AvatarUploader
  validates :title,  presence: true, length: { maximum: 200 }
  default_scope -> { order(created_at: :desc) }
  belongs_to :user, optional:true
  validates :title,  presence: true, length: { maximum: 50 }
  validates :year, presence: true, length: { is: 4 }, numericality: { only_integer: true}
  validates :isbn, presence: true, length: { is: 13 }, numericality: { only_integer: true}
  validates :author, presence: true, length: { maximum: 100 }
  validates :price, presence: true, length: { maximum: 10 }, numericality: true
  validates :course_number, presence: false, length: { maximum: 10 }
  validates :image, presence: false

end
