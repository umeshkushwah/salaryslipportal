class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :city
      t.integer :phone
      t.text :address
      t.string :state
      t.string :domain
      t.string :country
      t.string :pin_code

      t.timestamps null: false
    end
  end
end
