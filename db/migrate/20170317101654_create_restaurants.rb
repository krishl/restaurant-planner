class CreateRestaurants < ActiveRecord::Migration[5.0]
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :borough
      t.string :phone
      t.string :cuisine
      t.integer :user_id
      

      t.timestamps
    end
  end
end
