class EstimationViewController < UIViewController


  # Method to bind the values in the Project Object into proper UILabels
  def bind_project(project)

    #Using an NSString we set the text into the label, when we are using %@ we tell the object
    #to print it description as a string
    @total_effort_value_label.text = NSString.stringWithFormat("%@", project.total_effort) 
    
    @variation_value_label.text = NSString.stringWithFormat("%@", project.variation)

    @delivery_year_value_label.text = NSString.stringWithFormat("%@", project.delivery_year)
  end


  private

  def loadView

    layout_view

  end


  def layout_view

    self.view = UIView.alloc.init
    self.view.backgroundColor = UIColor.colorWithRed(0.298, green: 0.298, blue: 0.298, alpha: 1.0)

    @header_image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 320, 60))
    @header_image_view.image = UIImage.imageNamed("bgHeader.png")

    self.view.addSubview(@header_image_view)


    @title_label = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 320, 50))
    @title_label.text = "Estimation"
    @title_label.color = UIColor.colorWithRed(0.702, green: 0.702, blue: 0.702, alpha: 1.000)
    @title_label.backgroundColor = UIColor.clearColor
    @title_label.textAlignment = UITextAlignmentCenter
    @title_label.font = UIFont.fontWithName("AvenirNext-Bold", size: 25)

    self.view.addSubview(@title_label)


    @total_effort_title_label = UILabel.alloc.initWithFrame(CGRectMake(20, 60, 280, 30))
    @total_effort_title_label.text = "Total effort"
    @total_effort_title_label.color = UIColor.colorWithRed(0.702, green: 0.702, blue: 0.702, alpha: 1.000)
    @total_effort_title_label.backgroundColor = UIColor.clearColor
    @total_effort_title_label.font = UIFont.fontWithName("AvenirNextCondensed-DemiBold", size: 35)

    self.view.addSubview(@total_effort_title_label)


    @total_effort_value_label = UILabel.alloc.initWithFrame(CGRectMake(50, 50, 220, 180))
    @total_effort_value_label.color = UIColor.whiteColor
    @total_effort_value_label.backgroundColor = UIColor.clearColor
    @total_effort_value_label.textAlignment = UITextAlignmentCenter
    @total_effort_value_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 120)
    @total_effort_value_label.minimumFontSize = 50
    @total_effort_value_label.adjustsFontSizeToFitWidth = true

    self.view.addSubview(@total_effort_value_label)


    @total_effort_unit_label = UILabel.alloc.initWithFrame(CGRectMake(200, 160, 130, 70))
    @total_effort_unit_label.text = "HRS"
    @total_effort_unit_label.color = UIColor.colorWithRed(0.671, green: 1.000, blue: 0.353, alpha: 1.000)
    @total_effort_unit_label.backgroundColor = UIColor.clearColor
    @total_effort_unit_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 72)

    self.view.addSubview(@total_effort_unit_label)


    @variation_title_label = UILabel.alloc.initWithFrame(CGRectMake(20, 250, 280, 30))
    @variation_title_label.text = "Variation"
    @variation_title_label.color = UIColor.colorWithRed(0.702, green: 0.702, blue: 0.702, alpha: 1.000)
    @variation_title_label.backgroundColor = UIColor.clearColor
    @variation_title_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 30)

    self.view.addSubview(@variation_title_label)


    @variation_value_label = UILabel.alloc.initWithFrame(CGRectMake(50, 265, 220, 85))
    @variation_value_label.text = "52"
    @variation_value_label.color = UIColor.whiteColor
    @variation_value_label.backgroundColor = UIColor.clearColor
    @variation_value_label.textAlignment = UITextAlignmentCenter
    @variation_value_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 80)

    self.view.addSubview(@variation_value_label)


    @variation_unit_label = UILabel.alloc.initWithFrame(CGRectMake(190, 310, 120, 50))
    @variation_unit_label.text = "%"
    @variation_unit_label.color = UIColor.colorWithRed(0.671, green: 1.000, blue: 0.353, alpha: 1.000)
    @variation_unit_label.backgroundColor = UIColor.clearColor
    @variation_unit_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 50)

    self.view.addSubview(@variation_unit_label)


    @delivery_year_title_label = UILabel.alloc.initWithFrame(CGRectMake(20, 370, 280, 40))
    @delivery_year_title_label.text = "Delivery year"
    @delivery_year_title_label.color = UIColor.colorWithRed(0.702, green: 0.702, blue: 0.702, alpha: 1.000)
    @delivery_year_title_label.backgroundColor = UIColor.clearColor
    @delivery_year_title_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 30)

    self.view.addSubview(@delivery_year_title_label)


    @delivery_year_value_label = UILabel.alloc.initWithFrame(CGRectMake(150, 400, 150, 50))
    @delivery_year_value_label.text = "2040"
    @delivery_year_value_label.color = UIColor.whiteColor
    @delivery_year_value_label.backgroundColor = UIColor.clearColor
    @delivery_year_value_label.textAlignment = UITextAlignmentRight
    @delivery_year_value_label.font = UIFont.fontWithName("AvenirNextCondensed-Bold", size: 50)

    self.view.addSubview(@delivery_year_value_label)
  end

end
