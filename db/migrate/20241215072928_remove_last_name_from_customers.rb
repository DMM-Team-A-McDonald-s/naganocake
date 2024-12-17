class RemoveLastNameFromCustomers < ActiveRecord::Migration[6.1]
  def change
    remove_column :customers, :last_name, :string
  end
end
