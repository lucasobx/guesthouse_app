class AddPaymentMethodToGuesthouses < ActiveRecord::Migration[7.1]
  def change
    add_column :guesthouses, :payment_method, :text
  end
end
