class Product < ApplicationRecord

  has_one_attached :image
  has_many :comments
  belongs_to :user
  has_many :rentals
  has_many :likes
  has_many :dislikes

  validate :acceptable_image
  after_commit :add_default_cover, on: [:create, :update]


  def acceptable_image
    if image.attached?
      acceptable_types = ["image/jpeg", "image/png"]

      unless acceptable_types.include?(image.content_type)
        errors.add(:main_image, "must be a JPEG or PNG")
      end

    end
  end

  private

  def add_default_cover
    unless image.attached?
      self.image.attach(io: File.open(Rails.root.join("app", "assets", "images", "default.png")), filename: 'default.png' , content_type: "image/png  ")
    end
  end


end