class AddDetailsToCartItems < ActiveRecord::Migration[6.1]
  def change
    add_column :cart_items, :item_id, :integer
    add_column :cart_items, :customer_id, :integer
    add_column :cart_items, :amount, :integer
  end
end
