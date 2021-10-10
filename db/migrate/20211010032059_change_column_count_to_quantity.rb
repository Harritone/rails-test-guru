class ChangeColumnCountToQuantity < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_badges, :count, :quantity
  end
end
