class CreateUsersBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :user_badges do |t|
      t.integer :count, default: 1
      t.references :user, null: false, foreign_key: true
      t.references :badge, null: false, foreign_key: true

      t.timestamps
    end
  end
end
