class CreateUsersBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :users_badges do |t|
      t.integer :count, default: 1
      t.references :users, null: false, foreign_key: true
      t.references :badges, null: false, foreign_key: true

      t.timestamps
    end
  end
end
