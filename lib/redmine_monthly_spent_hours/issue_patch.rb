module RedmineMonthlySpentHours
  module IssuePatch
    def self.included(base)
      base.class_eval do
        has_many :time_entries
        
        # only this issue
        def last_month_spent_hours
          @last_month_spent_hours ||= spent_hours_for_month(1)
        end

        def this_month_spent_hours
          @this_month_spent_hours ||= spent_hours_for_month(0)
        end
        
        # with children issue
        def last_month_total_spent_hours
          @last_month_total_spent_hours ||= calculate_spent_hours(1)
        end

        def this_month_total_spent_hours
          @this_month_total_spent_hours ||= calculate_spent_hours(0)
        end

        private

        def calculate_spent_hours(month_offset)
          if leaf?
            spent_hours_for_month(month_offset)
          else
            target_date = Date.today.beginning_of_month - month_offset.month
            start_date = target_date.beginning_of_month
            end_date = target_date.end_of_month
      
            self_and_descendants.joins(:time_entries)
                                .where("#{TimeEntry.table_name}.spent_on" => start_date..end_date)
                                .sum("#{TimeEntry.table_name}.hours")
                                .to_f || 0.0
          end
        end

        def spent_hours_for_month(month_offset)
          target_date = Date.today.beginning_of_month - month_offset.month
          start_date = target_date.beginning_of_month
          end_date = target_date.end_of_month
    
          time_entries.where(spent_on: start_date..end_date).sum(:hours).to_f || 0.0
        end
      end
    end
  end
end