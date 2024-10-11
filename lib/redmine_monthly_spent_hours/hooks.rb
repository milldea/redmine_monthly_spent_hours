# 修正後のフッククラス
module RedmineMonthlySpentHours
  class Hooks < Redmine::Hook::ViewListener
    def view_issues_show_details_bottom(context = {})
      issue = context[:issue]
      if issue
        context[:controller].send(:render_to_string, {
          partial: 'issues/redmine_monthly_spent_hours',
          locals: {
            last_month_spent_hours: issue.last_month_spent_hours,
            this_month_spent_hours: issue.this_month_spent_hours,
            last_month_total_spent_hours: issue.last_month_total_spent_hours,
            this_month_total_spent_hours: issue.this_month_total_spent_hours,
          }
        })
      else
        ''
      end
    end
  end
end