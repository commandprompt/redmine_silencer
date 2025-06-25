require 'redmine'

Redmine::Plugin.register :redmine_silencer do
  name 'Redmine Silencer plugin'
  author 'Alex Shulgin <ash@commandprompt.com>'
  description 'A Redmine plugin to suppress issue email notifications.'
  version '0.2.4'
  url 'https://github.com/commandprompt/redmine_silencer'
  requires_redmine :version_or_higher => '5.0'
  permission :suppress_mail_notifications, {}
end

Journal.send(:include, RedmineSilencer::JournalPatch)

require_relative 'lib/redmine_silencer/issue_hooks'
require_relative 'lib/redmine_silencer/view_hooks'
