class EmployeeAttaindance < ActiveRecord::Base
  belongs_to :employee

  validates :employee_id, uniqueness: {scope: :check_in_date}

  scope :todays_attendance, -> { where(check_in_date: Time.now) }

  scope :current_month_attendance_by_employee, -> (emp_id){ where(employee_id: emp_id, check_in_date: [Time.now.beginning_of_month..Time.now.end_of_month]) }

  scope :late_employees, -> { where(is_late: true) }
end
