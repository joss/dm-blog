class CommentImage < ActiveRecord::Base
  ## External
  mount_uploader :image, ImageUploader

  ## Relationships
  belongs_to :comment

  ## Validations
  validates :image, presence: true
end
