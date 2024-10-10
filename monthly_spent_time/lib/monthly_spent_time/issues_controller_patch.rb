module MonthlySpentTime
  module IssuesControllerPatch
    def self.included(base)
      base.class_eval do
        alias_method :show_without_monthly_spent_time, :show
        def show
          show_without_monthly_spent_time
          
          last_month = Date.today.prev_month
          last_month_start = last_month.beginning_of_month
          last_month_end = last_month.end_of_month

          current_month_start = Date.today.beginning_of_month
          current_month_end = Date.today.end_of_month

          issue_id = @issue.id
          @last_month_hours = TimeEntry.where(issue_id: issue_id, spent_on: last_month_start..last_month_end).sum(:hours)
          @current_month_hours = TimeEntry.where(issue_id: issue_id, spent_on: current_month_start...current_month_end).sum(:hours)
        end
      end
    end
  end
end

IssuesController.send(:include, SpentTimeExtension::IssuesControllerPatch)