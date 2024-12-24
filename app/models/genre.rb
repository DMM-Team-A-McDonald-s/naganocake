class Genre < ApplicationRecord
  has_many :items

  validates :name, length: { minimum: 1, maximum: 50, message: 'を入力してください。' }
end
