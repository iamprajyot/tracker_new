class EmployeeAttaindance < ActiveRecord::Base
  belongs_to :employee

  validates :employee_id, uniqueness: {scope: :check_in_date}
end
