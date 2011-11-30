class Picture < ActiveRecord::Base
  has_attached_file :picture, :styles => { :medium => "750x750>", :thumb => "100x100>" }
  
  has_and_belongs_to_many :article
  has_and_belongs_to_many :projects
end
