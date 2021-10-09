class CreateBadges < ActiveRecord::Migration[6.1]
  def change
    create_table :badges do |t|
      t.string :image_url
      t.string :name
      t.integer :rule

      t.timestamps
    end
  end
end
