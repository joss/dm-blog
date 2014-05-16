class Comment < ActiveRecord::Base
  ## Relationships
  belongs_to :post
  has_many :remote_posts, dependent: :destroy

  ## Validations
  validates :body, presence: true

  ## Attributes
  accepts_nested_attributes_for :remote_posts, reject_if: ->(attrs){ attrs['title'].blank? }
end
