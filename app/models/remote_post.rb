class RemotePost < ActiveRecord::Base
  ## Relationships
  belongs_to :comment

  ## Validations
  with_options presence: true do |pt|
    pt.validates :title
    pt.validates :source
  end
end
