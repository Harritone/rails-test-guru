class Quiz < ApplicationRecord
  belongs_to :category
  has_many :taken_quizzes
  has_many :users, through: :taken_quizzes

  # scope :titles_by_cat, ->(category) { joins(:category).where('category.title' => category).pluck(:title).reverse } # => real=0.0017436999987694435
  # scope :titles_by_category, ->(category) { order(title: :desc).joins(:category).where('category.title' => category).pluck(:title) } # real=0.0008589999997639097

  def self.titles_by_category(category)
    order(title: :desc).joins(:category).where('category.title': category).pluck(:title)
  end
end
