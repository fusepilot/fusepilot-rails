class BlogController < ApplicationController
	respond_to :html, :json
  
  def index
    @articles = Article.all
    logger.info("test")
  end

  def show
    @articles = Article.all
    @article = Article.find_by_id params[:id]
    @comment = Comment.new
    @title = @article.title
    
    respond_with do |format|
      format.html do
        if request.xhr?
          render :partial => "blog/article", :locals => {:article => @article}, :layout => false
        end
      end
    end
  end
end
