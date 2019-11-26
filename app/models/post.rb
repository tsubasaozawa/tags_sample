class Post < ApplicationRecord
  has_many :post_categories, dependent: :destroy
  has_many :categories, through: :post_categories

  # 以下、タグの更新処理
  def save_categories(tags)
    current_tags = self.categories.pluck(:tag_name) unless self.categories.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags

    # Destroy old taggings:
    old_tags.each do |old_name|
      self.categories.delete Category.find_by(tag_name: old_name)
    end

    # Create new taggings:
    new_tags.each do |new_name|
      post_category = Category.find_or_create_by(tag_name: new_name)
      self.categories << post_category
    end
  end
end
