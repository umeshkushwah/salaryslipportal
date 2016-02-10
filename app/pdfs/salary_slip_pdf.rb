class SalarySlipPdf < Prawn::Document 

  include DateTimeHelper
  include ActionView::Helpers::NumberHelper
  require "open-uri"
  require "prawn/table"
  require "prawn"
  
  def initialize(salary_info, employee, current_org)
    super()
    @current_org = current_org
    @salary_info = salary_info
    @employee = employee
    building_photo = @current_org.logo.path
    image building_photo, height: 80, width: 150
    move_down 10
    employee_content
    move_down 20
    salary_content
  end

  def employee_content
    table employee_rows do
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [150, 200]
      row(0).font_style = :bold
      row(0).size = 15
    end
  end

  def employee_rows
    [['Employee Name', @employee.full_name],
    ['Employee ID', @employee.id],
    ['Address', @employee.address],
    ['City', @employee.city],
    ['Email', @employee.email]]
  end

  def salary_content
    table salary_rows do
      self.row_colors = ['DDDDDD', 'FFFFFF']
      self.column_widths = [150, 200]
      row(-1).font_style = :bold
      row(-1).size = 15
    end
  end

  def salary_rows
    [['Basic', number_to_currency(@salary_info.basic, precision: 2, unit: "")],
    ['HRA', number_to_currency(@salary_info.hra, precision: 2, unit: "")],
    ['Date', dd_mm_yyyy_date_helper(@salary_info.month)],
    ['Provident Fund', number_to_currency(@salary_info.provident_fund, precision: 2, unit: "")],
    ['Proffesional tax', number_to_currency(@salary_info.proffesional_tax, precision: 2, unit: "")],
    ['Gross Earning', number_to_currency(@salary_info.gross_earning, precision: 2, unit: "")],
    ['Gross Deduction', number_to_currency(@salary_info.gross_deduction, precision: 2, unit: "")],
    ['Net Pay', number_to_currency(@salary_info.net_pay, precision: 2, unit: "Rs ")]]
  end
end