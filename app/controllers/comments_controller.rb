class CommentsController < ApplicationController
  
  def create
    @commentable = Article.find_by_id(params[:article_id])
    @comment = @commentable.comments.create(params[:comment])
    redirect_to @commentable
  end
  
end
