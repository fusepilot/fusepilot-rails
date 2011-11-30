class Project < ActiveRecord::Base
  has_and_belongs_to_many :pictures

  has_attached_file :teaser, :styles => { :medium => "750x750>", :thumb => "100x100>" }
end
