module ApplicationHelper
  def to_halfchar(str)
    str.tr('A-Zａ-ｚ', 'A-Za-z') 
  end
end
