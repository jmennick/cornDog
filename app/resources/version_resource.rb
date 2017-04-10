class VersionResource < ApplicationResource
  model_name 'PaperTrail::Version'
  immutable

  attribute :item_type
  attribute :item_id
  attribute :event
  attribute :whodunnit
  attribute :object
  attribute :object_changes
  attribute :created_at, format: :time

  attribute :whodunnit_name

  def whodunnit_name
    unless @model.whodunnit.nil?
      return User.find(@model.whodunnit).name
    end
  end
end
