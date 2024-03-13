class AddVerifiedToCustomers < ActiveRecord::Migration[7.1]
  def change
    add_column :customers, :verified, :integer
  end
end
