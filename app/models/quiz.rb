class Quiz < ApplicationRecord
  belongs_to :category
  has_many :taken_quizzes
end
