class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :taken_quizzes
  has_many :gists, dependent: :destroy
  has_many :quizzes, through: :taken_quizzes
  has_many :created_quizzes, class_name: 'Quiz',
                             foreign_key: :creator_id,
                             dependent: :nullify

  validates :email, presence: true,
                    uniqueness: true,
                    format: { with: /\w+@\w+[[.]\w+]*/i }

  def taken_quizzes_by_level(level)
    Quiz.joins(:taken_quizzes).where('taken_quizzes.user_id': id, level: level)
  end

  def username
    if self.first_name || self.last_name
      "#{first_name} #{last_name}"
    else 
      email
    end
  end

  def admin?
    type == 'Admin'
  end

  def quiz_passage(quiz)
    taken_quizzes.order(id: :desc).find_by(quiz_id: quiz.id)
  end
end
