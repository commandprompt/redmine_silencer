module RedmineSilencer
  module JournalPatch
    def self.included(base)
      base.class_eval do
        # this method is the same as the original one in redmine, except that
        # it propagates 'notify' flag value to the newly split journal
        def split_private_notes
          if private_notes?
            if notes.present?
              if details.any?
                # Split the journal (notes/changes) so we don't have half-private journals
                journal = Journal.new(:journalized => journalized, :user => user, :notes => nil, :private_notes => false, :notify => self.notify?)
                journal.details = details
                journal.save
                self.details = []
                self.created_on = journal.created_on
              end
            else
              # Blank notes should not be private
              self.private_notes = false
            end
          end
          true
        end
      end
    end
  end
end
