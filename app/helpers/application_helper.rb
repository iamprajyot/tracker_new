module ApplicationHelper
	def current_month_date_range
		Time.now.beginning_of_month.to_date.to_s + ' to ' + Time.now.to_date.to_s
	end
end
