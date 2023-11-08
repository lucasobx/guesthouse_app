class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name
      t.text :description
      t.integer :size
      t.integer :max_capacity
      t.decimal :daily_rate
      t.boolean :bathroom
      t.boolean :balcony
      t.boolean :air_conditioning
      t.boolean :tv
      t.boolean :closet
      t.boolean :safe
      t.boolean :accessibility
      t.boolean :status
      t.references :guesthouse, null: false, foreign_key: true

      t.timestamps
    end
  end
end
