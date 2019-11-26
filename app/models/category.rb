class Category < ApplicationRecord
  has_many :post_categories,    dependent: :destroy
  has_many :posts,              through: :post_categories
  validates :tag_name,          presence: true, uniqueness: true
end
