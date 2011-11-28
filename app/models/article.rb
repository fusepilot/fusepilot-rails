class Article < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable
end
