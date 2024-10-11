module IssuesHelperPatch
  def self.included(base)
    base.class_eval do
      alias_method :original_render_half_width_custom_fields_rows, :render_half_width_custom_fields_rows

      def render_half_width_custom_fields_rows(issue)
        content = issue_fields_rows do |rows|
          if User.current.allowed_to?(:view_time_entries, @project)
            children_flag = !(issue.spent_hours == issue.total_spent_hours) # if true show details with children spent hours
            rows.send :right, l(:label_last_month_hours, scope: :redmine_monthly_spent_hours), 
            issue_spent_hours_extended_details(
              issue.last_month_spent_hours, 
              issue.last_month_total_spent_hours, 
              children_flag
            ), :class => 'spent-time'
            rows.send :right, l(:label_this_month_hours, scope: :redmine_monthly_spent_hours), 
            issue_spent_hours_extended_details(
              issue.this_month_spent_hours, 
              issue.this_month_total_spent_hours, 
              children_flag
            ), :class => 'spent-time'
          end
        end
        content + original_render_half_width_custom_fields_rows(issue)
      end
    end
  end
end