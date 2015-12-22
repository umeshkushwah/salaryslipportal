class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :employee_id
      t.string :name

      t.timestamps null: false
    end
  end
end
