module ApplicationHelper

  def reformatDate(dateGMT)
    date = dateGMT.getlocal
    return date.strftime("%b %-d, %Y at %l:%M %p")
  end
  
end
