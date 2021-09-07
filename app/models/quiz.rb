class Quiz < ApplicationRecord
  belongs_to :category
  belongs_to :creator, class_name: 'User', foreign_key: :user_id
  has_many :taken_quizzes, dependent: :destroy
  has_many :users, through: :taken_quizzes

  def self.titles_by_category(category)
    order(title: :desc).joins(:category)
      .where('category.title': category).pluck(:title)
  end
end
