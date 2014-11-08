class Post < ActiveRecord::Base
  belongs_to :site
  paginates_per 30
end
