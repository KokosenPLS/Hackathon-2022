class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :comments
  has_many :products
  has_many :rentals
  has_many :likes
  has_many :dislikes

  def full_name
    first_name + " " + last_name
  end

end
