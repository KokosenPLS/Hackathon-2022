class Product < ApplicationRecord

  has_one_attached :image, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :user
  has_many :rentals, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :dislikes, dependent: :destroy

  validate :acceptable_image


  def acceptable_image
    Rails.logger.debug "Sjekker om det er attached"
    if image.attached?
      Rails.logger.debug "Bildet er attached"
      acceptable_types = ["image/jpeg", "image/jpg", "image/png"]

      unless acceptable_types.include?(image.content_type)
        errors.add(:main_image, "must be a JPEG or PNG")
      end
    else
      self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.png")), filename: 'default.png' , content_type: "image/png  ")
    end
  end


end