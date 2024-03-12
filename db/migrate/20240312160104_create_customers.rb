class CreateCustomers < ActiveRecord::Migration[7.1]
  def change
    create_table :customers do |t|
      t.string :email
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :title
      t.string :role
      t.integer :score

      t.timestamps
    end
  end
end
