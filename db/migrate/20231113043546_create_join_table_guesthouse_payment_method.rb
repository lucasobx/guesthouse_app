class CreateJoinTableGuesthousePaymentMethod < ActiveRecord::Migration[7.1]
  def change
    create_join_table :guesthouses, :payment_methods do |t|
      t.index :guesthouse_id
      t.index :payment_method_id
    end
  end
end
