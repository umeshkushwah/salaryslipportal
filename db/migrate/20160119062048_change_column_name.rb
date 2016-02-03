class ChangeColumnName < ActiveRecord::Migration
  def change
    rename_column :salary_infos, :extra, :allowance_added
    add_column :salary_infos, :allowance_deduction, :integer
  end
end
