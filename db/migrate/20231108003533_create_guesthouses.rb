class CreateGuesthouses < ActiveRecord::Migration[7.1]
  def change
    create_table :guesthouses do |t|
      t.string :brand_name
      t.string :corporate_name
      t.string :registration_number
      t.string :phone_number
      t.string :email
      t.text :description
      t.boolean :pets
      t.text :use_policy
      t.datetime :checkin
      t.datetime :checkout
      t.boolean :status

      t.timestamps
    end
  end
end
