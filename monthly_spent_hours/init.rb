require 'redmine'
require_dependency File.expand_path('../lib/monthly_spent_hours/issue_patch', __FILE__)
require_dependency File.expand_path('../lib/monthly_spent_hours/hooks', __FILE__)
require_dependency File.expand_path('../app/helpers/monthly_spent_hours_helper', __FILE__)

Redmine::Plugin.register :monthly_spent_hours do
  name 'Monthly Spent Hours plugin'
  author 'Author name'
  description 'Add last month and this month'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  settings :default => {'empty' => true}, :partial => 'settings/monthly_spent_hours'
end

if Rails.version > '6.0' && Rails.autoloaders.zeitwerk_enabled?
	Rails.application.config.after_initialize do
		unless Issue.included_modules.include? MonthlySpentHours::IssuePatch
			Issue.send(:include, MonthlySpentHours::IssuePatch)
		end
	end
else
	((Rails.version > "5")? ActiveSupport::Reloader : ActionDispatch::Callbacks).to_prepare do
		require_dependency 'issue'
		unless Issue.included_modules.include? MonthlySpentHours::IssuePatch
			Issue.send(:include, MonthlySpentHours::IssuePatch)
		end
	end
end

# Rails.application.config.i18n.load_path += Dir[File.join(__dir__, 'config', 'locales', '*.yml')]
