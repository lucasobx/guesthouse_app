class ModifyPaymentMethodsForEnum < ActiveRecord::Migration[7.1]
  def change
    remove_column :payment_methods, :name, :string
    add_column :payment_methods, :method_type, :integer, default: 0
  end
end
