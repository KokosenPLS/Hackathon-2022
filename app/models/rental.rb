class Rental < ApplicationRecord
  belongs_to :user
  belongs_to :product
  has_many :likes
  has_many :dislikes

  enum :status, {
    pending: 0,
    active: 1,
    done: 2
  }

end
