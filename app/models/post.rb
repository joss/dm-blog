class Post < ActiveRecord::Base
  ## Validations
  with_options presence: true do |pt|
    pt.validates :username
    pt.validates :title
    pt.validates :body
  end
end
