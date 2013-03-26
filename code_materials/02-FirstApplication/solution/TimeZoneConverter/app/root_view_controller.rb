class RootViewController < UIViewController
  
  include UI_Elements
  include TimeOffset

	def set_current_time
    calendar = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)
    @offsetDate = NSDate.date
    components = calendar.components (NSMinuteCalendarUnit,fromDate:@offsetDate)   
    
    @stepper.value = components.minute 
    @currentTimeLabel.text = month_year_string(@offsetDate)
  end

	def set_remote_time_zone

    @remoteTimeZoneTextField.text = "Europe/Zurich"
    @remoteTimeZoneTextField.returnKeyType = UIReturnKeyDone

  end

  def set_remote_time

    convertZone = NSTimeZone.timeZoneWithName(@remoteTimeZoneTextField.text)

    formatter = NSDateFormatter.alloc.init
    formatter.setDateFormat('HH:mm')
    formatter.setTimeZone(convertZone)

    dateFormat = formatter.stringFromDate(@offsetDate)

    @convertDate = formatter.dateFromString(dateFormat)
    @remoteTimeLabel.text = "UTC "+(convertZone.secondsFromGMT/3600).to_s + "  "+ dateFormat

  end

  def stepperPressed (sender)

    calendar = NSCalendar.alloc.initWithCalendarIdentifier(NSGregorianCalendar)

    components = calendar.components (NSMinuteCalendarUnit,fromDate:@offsetDate)   
    minute = components.minute

    if minute > @stepper.value
      @offsetDate = NSDate.alloc.initWithTimeInterval(-60,sinceDate:@offsetDate)
    else 
      @offsetDate = NSDate.alloc.initWithTimeInterval(60,sinceDate:@offsetDate)
    end

    components = calendar.components (NSMinuteCalendarUnit,fromDate:@offsetDate)
    @stepper.value = components.minute
    @currentTimeLabel.text = month_year_string(@offsetDate)
  end

  def textFieldShouldReturn (textField)
    @remoteTimeZoneTextField.resignFirstResponder
  end

  def handleSingleTap
    @remoteTimeZoneTextField.resignFirstResponder
  end

  def viewDidLoad  

    singleTap = UITapGestureRecognizer.alloc.initWithTarget(self, action: :'handleSingleTap')
    self.view.addGestureRecognizer(singleTap)

    @currentTimeLabel =  time_label(25,65)
    @stepper = ui_stepper (220,75)

    @remoteTimeZoneTextField = time_zone_text_field(25,185)
    @remoteTimeZoneTextField.delegate = self
    @remoteTimeLabel =  time_label(25,210)

    chooseconvertButton = select_time_zone_Button(220,175)
    chooseconvertButton.addTarget(self, action: :'set_remote_time', forControlEvents:UIControlEventTouchUpInside)

    view.addSubview(@currentTimeLabel)
    view.addSubview(@remoteTimeZoneTextField)
    view.addSubview(@remoteTimeLabel)
    view.addSubview(@stepper)
    view.addSubview(chooseconvertButton)


    set_current_time
    set_remote_time_zone
  
    view.backgroundColor = UIColor.alloc.initWithPatternImage(UIImage.imageNamed("bgApp.png"))

  end  

end