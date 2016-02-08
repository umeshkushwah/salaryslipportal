class SalarySlipPdf < Prawn::Document 

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
    [['Basic', @salary_info.basic.round.round(2)],
    ['HRA', @salary_info.hra.round(2)],
    ['Date', @salary_info.month],
    ['Provident Fund', @salary_info.provident_fund.round(2)],
    ['Proffesional tax', @salary_info.proffesional_tax.round(2)],
    ['Gross Earning', @salary_info.gross_earning.round(2)],
    ['Gross Deduction', @salary_info.gross_deduction.round(2)],
    ['Net Pay', @salary_info.net_pay.round(2)]]
  end
end