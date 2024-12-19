class AddColumnsToOrders < ActiveRecord::Migration[6.1]
  def change
    add_column :orders, :customer_id, :integer
    add_column :orders, :postal_code, :string
    add_column :orders, :address, :string
    add_column :orders, :name, :string
    add_column :orders, :shipping_cost, :integer
    add_column :orders, :total_payment, :integer
    add_column :orders, :payment_method, :integer
    add_column :orders, :status, :integer
  end
end
