class Category < ApplicationRecord
  has_many :quizzes

  validates :title, presence: true

  default_scope { order(:title) }
end
