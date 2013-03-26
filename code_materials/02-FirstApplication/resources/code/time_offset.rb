module TimeOffset

  def month_year_string (date)

    format = NSDateFormatter.alloc.init
    format.setDateFormat("MMM dd, yyyy HH:mm")  
    dateString = format.stringFromDate(date)

    dateString
  end

  def hour_string (date)
    format = NSDateFormatter.alloc.init
    format.setDateFormat("HH")  
    dateString = format.stringFromDate(date)

    dateString
  end

  def minute_string (date)
    format = NSDateFormatter.alloc.init
    format.setDateFormat(": mm")  
    dateString = format.stringFromDate(date)

    dateString
  end
  
end 