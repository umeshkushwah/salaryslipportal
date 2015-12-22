class CreateSalaryInfos < ActiveRecord::Migration
  def change
    create_table :salary_infos do |t|
      t.integer :employee_id
      t.float :basic
      t.float :hra
      t.float :provident_fund
      t.float :proffesional_tax
      t.float :gross_earning
      t.float :gross_deduction
      t.float :net_pay
      t.float :esic
      t.integer :extra
      t.integer :working_days
      t.date :month

      t.timestamps null: false
    end
  end
end
