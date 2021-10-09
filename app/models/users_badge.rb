class UsersBadge < ApplicationRecord
  belongs_to :users
  belongs_to :badges
end
