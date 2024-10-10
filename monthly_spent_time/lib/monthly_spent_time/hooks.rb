module MonthlySpentTime
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, :partial => 'issues/monthly_spent_time'
  end
end