# 修正後のフッククラス
module MonthlySpentHours
  class Hooks < Redmine::Hook::ViewListener
    render_on :view_issues_show_details_bottom, partial: 'issues/monthly_spent_hours'

    def view_issues_show_details_bottom(context = {})
      issue = context[:issue]
      if issue
        context[:controller].send(:render_to_string, {
          partial: 'issues/monthly_spent_hours',
          locals: {
            last_month_spent_hours: issue.last_month_spent_hours,
            current_month_spent_hours: issue.current_month_spent_hours,
            last_month_total_spent_hours: issue.last_month_total_spent_hours,
            current_month_total_spent_hours: issue.current_month_total_spent_hours,
          }
        })
      else
        ''
      end
    end
  end
end