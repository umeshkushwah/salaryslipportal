module SetLayout

  extend ActiveSupport::Concern

  def set_layout
    if current_employee.is_admin?
      'admin'
    else
      'employees'
    end
  end
end