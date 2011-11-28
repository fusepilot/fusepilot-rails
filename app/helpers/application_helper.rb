module ApplicationHelper
  
  def format_date(date)
    date.strftime("%B #{date.day.ordinalize}, %Y")
  end
  
  def list_tags(tags)
    tags.join(", ")
  end
  
end
