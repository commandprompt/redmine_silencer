require 'redmine'

Redmine::Plugin.register :redmine_silencer do
  name 'Redmine Silencer 2'
  author 'Tobias Fischer'
  description 'A Redmine plugin to suppress email notifications (at will) when updating issues. (This is a fork by GitHub users @commandprompt, @tofi86 and @paginagmbh of the original plugin made by @a1exsh!)'
  version '0.4.0'
  url 'https://github.com/paginagmbh/redmine_silencer'
  requires_redmine :version_or_higher => '2.4.x'

  permission :suppress_mail_notifications, {}
  
  settings :default => {
    'silencer_default' => false
  }, :partial => 'redmine_silencer_settings'
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
