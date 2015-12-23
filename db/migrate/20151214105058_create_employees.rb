class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :first_name
      t.string :last_name
      t.text :address
      t.string :pin_code
      t.string :city
      t.integer :mobile
      t.date :dob
      t.string :degignation
      t.string :gender
      t.date :date_of_joining
      t.integer :orgnization_id

      t.timestamps null: false
    end
  end
end
