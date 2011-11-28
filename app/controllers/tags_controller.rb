class TagsController < ApplicationController
  
  def show
    @tag = ActsAsTaggableOn::Tag.find_by_id(params[:id])
    @articles = Article.tagged_with @tag.name
  end
  
end
