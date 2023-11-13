class DropGuesthousesPaymentMethodsJoinTable < ActiveRecord::Migration[7.1]
  def change
    drop_table :guesthouses_payment_methods
  end
end
