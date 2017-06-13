module EmployeesHelper
  def archive_unarchive_user(employee)
    html = ""
    if employee.is_deleted?
      html << link_to("<i title='Un-archive' class='glyphicon glyphicon-repeat'></i>".html_safe,
      	employee, method: :delete, data: { confirm: "Are you sure you want to activate this employee?" })
    else
      html << link_to("<i title='Archive' class='glyphicon glyphicon-trash'></i>".html_safe,
      	employee, method: :delete, data: { confirm: "Are you sure you want to archive this employee?" })
    end
    return html.html_safe
  end

  def emp_name_link(emp)
  	link_to(emp.username, home_employee_current_month_attendance_path(emp_id: emp.id))
  end
end
