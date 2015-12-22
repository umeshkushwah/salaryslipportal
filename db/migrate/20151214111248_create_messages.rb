class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :message
      t.integer :employee_id

      t.timestamps null: false
    end
  end
end
