class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:dashboard, :todays_stats]

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
      flash[:error] = 'Either you are not reqiesterd or your profile is archived. Contact administrator..'
    end
    redirect_to root_path
  end


  def dashboard
    todays_attendance = EmployeeAttaindance.todays_attendance
    @total_employees = Employee.count
    @active_employees = Employee.active.count
    @todays_logged_in_count = todays_attendance.count
    @todays_late_arrivals = todays_attendance.late_employees.count
    total_min = (todays_attendance.sum(:check_in_hour) * 60) + todays_attendance.sum(:check_in_minute)
    total_min = total_min / @todays_logged_in_count rescue 0
    @todays_avg_in_time = (total_min / 60).to_i.to_s + ':' + (total_min % 60).to_i.to_s rescue '0'
  end

  def todays_stats
    if params[:stat_type].eql?('late')
      @todays_attendance = EmployeeAttaindance.includes(:employee).todays_attendance.late_employees
    else
      @todays_attendance = EmployeeAttaindance.includes(:employee).todays_attendance
    end
  end

  private
  def isEmployeeLate?(tracked_time)
    ((tracked_time.hour * 60) + tracked_time.min) > 50
  end
end
