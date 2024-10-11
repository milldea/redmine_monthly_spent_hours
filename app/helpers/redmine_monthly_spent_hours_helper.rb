module RedmineMonthlySpentHoursHelper
  def issue_spent_hours_extended_details(spent_hours, total_spent_hours, children_flag)
    if !children_flag
      l_hours_short(spent_hours)
    else
      s = l_hours_short(spent_hours)
      s += " (#{l(:label_total)}: #{l_hours_short(total_spent_hours)})"
      s.html_safe
    end
  end  
end

unless ApplicationHelper.included_modules.include? RedmineMonthlySpentHoursHelper
  ApplicationHelper.send(:include, RedmineMonthlySpentHoursHelper)
end
