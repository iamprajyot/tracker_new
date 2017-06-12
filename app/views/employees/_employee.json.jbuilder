json.extract! employee, :id, :username, :is_deleted, :created_at, :updated_at
json.url employee_url(employee, format: :json)
