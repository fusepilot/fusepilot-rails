class Article < ActiveRecord::Base
  acts_as_commentable
  acts_as_taggable

  has_attached_file :teaser, :styles => { :medium => "750x750>", :thumb => "100x100>" }

  has_and_belongs_to_many :pictures
end
