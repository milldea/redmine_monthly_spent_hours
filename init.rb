require 'redmine'
require_dependency File.expand_path('../lib/redmine_monthly_spent_hours/issue_patch', __FILE__)
require_dependency File.expand_path('../app/helpers/redmine_monthly_spent_hours_helper', __FILE__)
require_dependency File.expand_path('../app/helpers/issues_helper_patch', __FILE__)


Redmine::Plugin.register :redmine_monthly_spent_hours do
  name 'Redmine Monthly Spent Hours plugin'
  author 'Author name'
  description 'Add last and this month spent time details'
  version '0.0.1'
  url 'https://github.com/milldea/redmine_redmine_monthly_spent_hours'
  author_url 'http://example.com/about'
  settings :default => {'empty' => true}, :partial => 'settings/redmine_monthly_spent_hours'
end

if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
	Rails.application.config.after_initialize do
		unless Issue.included_modules.include? RedmineMonthlySpentHours::IssuePatch
			Issue.send(:include, RedmineMonthlySpentHours::IssuePatch)
		end
		unless IssuesHelper.included_modules.include? IssuesHelperPatch
			IssuesHelper.send(:include, IssuesHelperPatch)
		end
	end
else
	((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare do
		require_dependency 'issue'
		unless Issue.included_modules.include? RedmineMonthlySpentHours::IssuePatch
			Issue.send(:include, RedmineMonthlySpentHours::IssuePatch)
		end
		unless IssuesHelper.included_modules.include? IssuesHelperPatch
			IssuesHelper.send(:include, IssuesHelperPatch)
		end
	end
end