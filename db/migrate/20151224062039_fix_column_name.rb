class FixColumnName < ActiveRecord::Migration
  def change
    rename_column :employees, :orgnization_id, :organization_id
  end
end
