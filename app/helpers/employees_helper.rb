module EmployeesHelper
  def archive_unarchive_user(employee)
    html = ""
    if employee.is_deleted?
      html << link_to("<i title='Un-archive' class='glyphicon glyphicon-repeat'></i>".html_safe, employee, method: :delete, data: { confirm: "Are you sure you want to archive this employee?" })
    else
      html << link_to("<i title='Archive' class='glyphicon glyphicon-trash'></i>".html_safe, employee, method: :delete, data: { confirm: "Are you sure you want to archive this employee?" })
    end
    return html.html_safe
  end
end
