class ChangeMobileFormatInEmployee < ActiveRecord::Migration
  def change
    change_column :employees, :mobile, :string
  end
end
