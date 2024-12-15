class Item < ApplicationRecord
  
  validates :name, presence: true
  validates :introduction, presence: true
  validates :price, presence: true
  validates :is_active, presence: true
  validates :image, presence: true

  has_one_attached :image
  
end
