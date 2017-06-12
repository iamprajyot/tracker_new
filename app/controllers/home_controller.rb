class HomeController < ApplicationController
  def index
  end

  def mark_attendance
    employee = Employee.where(username: params[:username], is_deleted: false).first
    if employee
      current_time = Time.now
      check_in = EmployeeAttaindance.new(employee_id: employee.id,
        check_in_date: current_time,
        check_in_hour: current_time.hour,
        check_in_minute: current_time.min, is_late: isEmployeeLate?(current_time))
      if check_in.save
        flash[:success] = check_in.is_late? ? 'You are late' : 'You successfuly checked-in'
      else
        flash[:error] = check_in.errors.messages.key?(:employee_id) ? 'You already marked your attaindance for today' : 'Problem with check-in. Try again.'
      end
    else
      flash[:error] = 'You are not reqiesterd or your profile is archived'
    end
    redirect_to root_path
  end


  def dashboard
    @total_employees = Employee.count
    @active_employees = Employee.where(is_deleted: false).count
  end

  private
  def isEmployeeLate?(tracked_time)
    ((tracked_time.hour * 60) + tracked_time.min) > 600
  end
end
