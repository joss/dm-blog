class Post < ActiveRecord::Base
  ## Relationships
  has_many :comments, dependent: :destroy

  ## Validations
  with_options presence: true do |pt|
    pt.validates :username
    pt.validates :title
    pt.validates :body
  end
end
