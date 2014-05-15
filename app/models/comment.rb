class Comment < ActiveRecord::Base
  ## Relationships
  belongs_to :post
  has_one :remote_post, dependent: :destroy

  ## Validations
  validates :body, presence: true

  ## Attributes
  accepts_nested_attributes_for :remote_post, reject_if: ->(attrs){ attrs['title'].blank? }
end
