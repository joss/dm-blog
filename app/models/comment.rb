class Comment < ActiveRecord::Base
  ## Relationships
  belongs_to :post

  ## Validations
  validates :body, presence: true

  def validation_errors
    self.errors.full_messages.join('<br/>')
  end


  def as_json opts = {}
    super opts.merge(methods: [:validation_errors])
  end
end
