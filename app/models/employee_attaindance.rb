class EmployeeAttaindance < ActiveRecord::Base
  belongs_to :employee

  validates :employee_id, uniqueness: {scope: :check_in_date}

  scope :todays_attendance, -> { where(check_in_date: Time.now) }

  scope :late_employees, -> { where(is_late: true) }
end
