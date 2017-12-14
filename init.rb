require 'redmine'

Redmine::Plugin.register :redmine_silencer do
  name 'Redmine Silencer plugin'
  author 'Alex Shulgin <ash@commandprompt.com>'
  description 'A Redmine plugin to suppress issue email notifications.'
  version '0.2.1'
  url 'https://github.com/commandprompt/redmine_silencer'
  requires_redmine :version_or_higher => '2.0.x'

  permission :suppress_mail_notifications, {}
end

prepare_block = Proc.new do
  Journal.send(:include, RedmineSilencer::JournalPatch)
end

if Rails.env.development?
  ActionDispatch::Reloader.to_prepare { prepare_block.call }
else
  prepare_block.call
end

require 'redmine_silencer/issue_hooks'
require 'redmine_silencer/view_hooks'
