# Describes a source document provided in a journal entry
class SourceDocument < ApplicationRecord
  belongs_to :journal_entry

  # mount_base64_uploader :file, SourceDocumentUploader, file_name: lambda do |d|
  #   "source_document.#{d.id}.#{d.name}"
  # end
  alias_attribute :data, :file

  # def data=(val)
  #   self.file = val
  # end
end
