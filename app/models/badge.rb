class Badge < ApplicationRecord
  enum rule: { category_complete: 0, level_complete: 1, first_attempt: 2, finaly: 3 }

  validates :name, uniqueness: true
  validates :image_url, presence: true
  validates :rule, presence: true
end
