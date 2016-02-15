class RemoveAllowanceDeductionFromSalaryInfo < ActiveRecord::Migration
  def change
    remove_column :salary_infos, :allowance_deduction
  end
end
