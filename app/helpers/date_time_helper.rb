module DateTimeHelper

  def dd_mm_yyyy_date_helper(date)
    date.strftime("%d %B %Y")
  end

  def dd_MM_yyyy_date_helper(date)
    date.strftime("%d/%m/%Y")
  end

end
