class BadgesController < ApplicationController
  def my_badges
    @badges = current_user.badges
  end
end
