class Book < ApplicationRecord
  mount_uploader :image, AvatarUploader
<<<<<<< HEAD
  validates :title,  presence: true, length: { maximum: 200 }

  belongs_to :user, optional: true
=======
  belongs_to :user
>>>>>>> cd6ab484838deb38e3130c938b5286357a168106
  validates :title,  presence: true, length: { maximum: 50 }
  validates :year, presence: true, length: { is: 4 }, numericality: { only_integer: true}
  validates :isbn, presence: true, length: { is: 13 }, numericality: { only_integer: true}
  validates :author, presence: true, length: { maximum: 100 }
  validates :price, presence: true, length: { maximum: 10 }, numericality: true
  validates :course_number, presence: false, length: { maximum: 10 }
  validates :image, presence: false

end
