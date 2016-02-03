class AddTotalWorkingDaysToSalaryInfos < ActiveRecord::Migration
  def change
    add_column :salary_infos, :total_working_days, :integer
  end
end
