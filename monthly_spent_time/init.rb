require 'redmine'
require_dependency File.expand_path('../lib/monthly_spent_time/hooks', __FILE__)

Redmine::Plugin.register :monthly_spent_time do
  name 'Monthly Spent Time plugin'
  author 'Author name'
  description 'This is a plugin for Redmine'
  version '0.0.1'
  url 'http://example.com/path/to/plugin'
  author_url 'http://example.com/about'
  settings :default => {'empty' => true}, :partial => 'settings/monthly_spent_time'
end


# Rails.application.config.i18n.load_path += Dir[File.join(__dir__, 'config', 'locales', '*.yml')]
