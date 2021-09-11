class Quiz < ApplicationRecord
  belongs_to :category
  belongs_to :creator, optional: true, class_name: 'User', foreign_key: :creator_id
  has_many :taken_quizzes, dependent: :destroy
  has_many :users, through: :taken_quizzes
  has_many :questions

  validates :title, presence: true
  validates :level, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :title, uniqueness: { scope: [:level, :category] }

  scope :by_level, ->(level) { where(level: level) }
  scope :easy, -> { by_level(0..1) }
  scope :medium, -> { by_level(2..4) }
  scope :hard, -> { by_level(5..Float::INFINITY) }
  scope :by_category_title, ->(category) { joins(:category).where(categories: { title: category }) }

  def self.titles_by_category(category_title)
    by_category_title(category_title).pluck(:title)
  end
end
