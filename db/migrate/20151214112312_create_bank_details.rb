class CreateBankDetails < ActiveRecord::Migration
  def change
    create_table :bank_details do |t|
      t.string :bank_name
      t.string :branch_name
      t.text :address
      t.string :city
      t.string :account_number
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
