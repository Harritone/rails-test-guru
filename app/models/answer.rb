class Answer < ApplicationRecord
  belongs_to :question

  validates :body, presence: true

  scope :all_correct, -> { where(correct: true) }
end
