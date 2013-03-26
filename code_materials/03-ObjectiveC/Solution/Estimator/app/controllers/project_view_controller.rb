class ProjectViewController < UIViewController

  private

  def loadView

    customize_segmented_control
    layout_view

  end


  # Method to customize the appearance of the UISegmentedControl
  def customize_segmented_control

    # Lets load the images from their respective files
    segmented_control_normal_background = UIImage.imageNamed("bgSegmentedControlNormal.png")
    segmented_control_selected_background = UIImage.imageNamed("bgSegmentedControlSelected.png")
    segmented_control_separator = UIImage.imageNamed("bgSegmentedControlSeparator.png")


    # Apply the image for the background when the segment is not selected
    UISegmentedControl.appearance.setBackgroundImage(segmented_control_normal_background,
                                                     forState:UIControlStateNormal,
                                                     barMetrics: UIBarMetricsDefault)

    # Apply the image for the background when the segment is selected
    UISegmentedControl.appearance.setBackgroundImage(segmented_control_selected_background,
                                                     forState:UIControlStateSelected,
                                                     barMetrics: UIBarMetricsDefault)


    # Apply the image for the divider of the control
    UISegmentedControl.appearance.setDividerImage(segmented_control_separator,
                                                  forLeftSegmentState: UIControlStateNormal,
                                                  rightSegmentState:UIControlStateSelected,
                                                  barMetrics:UIBarMetricsDefault)



    # Also we need to change the font of the titles, the first step is to load the font into the memory
    segmented_control_title_font = UIFont.fontWithName("AvenirNextCondensed-Bold", size:20)


    # To apply certain visual attributes to Apple's default controls, we need to use a iOS 5 technology
    # called Skins. To work with screens we must create a dictionary with the key of the property we want
    # to change and the proper value
    normal_title_text_attributes = NSMutableDictionary.alloc.init
    normal_title_text_attributes.setValue(segmented_control_title_font, forKey:UITextAttributeFont)

    normal_title_text_color = UIColor.colorWithRed(0.545, green:0.749, blue:0.349, alpha:1.0)
    normal_title_text_attributes.setValue(normal_title_text_color, forKey: UITextAttributeTextColor)

    normal_title_text_attributes.setValue(UIColor.clearColor, forKey: UITextAttributeTextShadowColor)

    # Using Skins you can change the visual properties of all the same kind of controls at the same time,
    # no matter if they were created on another class or in another excecution time. To archive this
    # only send the messages to the class
    #
    # On the other side if you want only to modify one particular control, the following like will work
    # on the instance instead of the class
    UISegmentedControl.appearance.setTitleTextAttributes(normal_title_text_attributes, forState:UIControlStateNormal)



    selected_title_text_attributes = NSMutableDictionary.alloc.init
    selected_title_text_attributes.setValue(segmented_control_title_font, forKey:UITextAttributeFont)

    selected_title_text_color = UIColor.colorWithRed(0.200, green:0.200, blue:0.200, alpha:1.0)
    selected_title_text_attributes.setValue(selected_title_text_color, forKey:UITextAttributeTextColor)

    UISegmentedControl.appearance.setTitleTextAttributes(selected_title_text_attributes, forState:UIControlStateSelected)

  end


  def layout_view

    # Initialize a new view for the controller
    self.view = UIView.alloc.init
    self.view.backgroundColor = UIColor.colorWithRed(0.902, green: 0.902, blue: 0.902, alpha: 1.0)

    # The following is an initialization and add of controls into the view


    # First create an instance of UIImageView, this control will present an Image into the view
    # for this case a black header
    @header_image_view = UIImageView.alloc.initWithFrame(CGRectMake(0, 0, 320, 60))
    @header_image_view.image = UIImage.imageNamed("bgHeader.png")

    self.view.addSubview(@header_image_view)


    # Next we create an instance of UILabel, tellling it the position on the screen that
    # we want it to be drawn. For this we use a c struct called CGFrame
    @title_label = UILabel.alloc.initWithFrame(CGRectMake(0, 0, 320, 50))
    @title_label.text = "Project Estimator"
    @title_label.color = UIColor.colorWithRed(0.702, green: 0.702, blue: 0.702, alpha: 1.000)
    @title_label.backgroundColor = UIColor.clearColor
    @title_label.textAlignment = UITextAlignmentCenter

    # To specify a custom Font we need to tell the proper name of it and the size that we want
    @title_label.font = UIFont.fontWithName("AvenirNext-Bold", size: 25)

    # Then we add it to the view like this way
    self.view.addSubview(@title_label)


    @number_of_screens_text_field = UITextField.alloc.initWithFrame(CGRectMake(10, 75, 300, 45))
    @number_of_screens_text_field.borderStyle = UITextBorderStyleRoundedRect
    @number_of_screens_text_field.delegate = self
    @number_of_screens_text_field.keyboardType = UIKeyboardTypeNumbersAndPunctuation
    @number_of_screens_text_field.text = ""
    @number_of_screens_text_field.background = UIImage.imageNamed("bgTextField.png")
    @number_of_screens_text_field.borderStyle = UITextBorderStyleNone
    @number_of_screens_text_field.placeholder = "Number of Screens"
    @number_of_screens_text_field.textColor = UIColor.colorWithRed(0.451, green:0.451, blue:0.451, alpha:1.0)
    @number_of_screens_text_field.textAlignment = UITextAlignmentCenter
    @number_of_screens_text_field.font = UIFont.fontWithName("AvenirNextCondensed-DemiBold", size:25)
    @number_of_screens_text_field.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter

    self.view.addSubview(@number_of_screens_text_field)


    @complexity_label = UILabel.alloc.initWithFrame(CGRectMake(10, 140, 300, 30))
    @complexity_label.text = "Complexity"
    @complexity_label.color = UIColor.colorWithRed(0.400, green: 0.400, blue: 0.400, alpha: 1.0)
    @complexity_label.backgroundColor = UIColor.clearColor
    @complexity_label.font = UIFont.fontWithName("AvenirNext-DemiBold", size: 20)
    @complexity_label.textAlignment = UITextAlignmentCenter

    self.view.addSubview(@complexity_label)


    # For the UISegmentedControl to work, we need to pass him the possible values
    # in this case a NSArray do the trick
    @complexity_values = NSMutableArray.alloc.init
    @complexity_values.addObject("Low")
    @complexity_values.addObject("High")

    # We create an instance of a UISegmentedControl, setting the allowed values for it
    @complexity_segmented_control = UISegmentedControl.alloc.initWithItems(@complexity_values)
    @complexity_segmented_control.frame = CGRectMake(10, 170, 300, 30)


    # Its not required to set a selected index, but for this example we select the first segment
    @complexity_segmented_control.selectedSegmentIndex = 0

    self.view.addSubview(@complexity_segmented_control)


    @outsourced_label = UILabel.alloc.initWithFrame(CGRectMake(10, 210, 300, 30))
    @outsourced_label.text = "Outsourced"
    @outsourced_label.color = UIColor.colorWithRed(0.400, green: 0.400, blue: 0.400, alpha: 1.0)
    @outsourced_label.backgroundColor = UIColor.clearColor
    @outsourced_label.font = UIFont.fontWithName("AvenirNext-DemiBold", size: 20)
    @outsourced_label.textAlignment = UITextAlignmentCenter

    self.view.addSubview(@outsourced_label)


    @outsourced_values = NSMutableArray.alloc.init
    @outsourced_values.addObject("No")
    @outsourced_values.addObject("Yes")

    @outsourced_segmented_control = UISegmentedControl.alloc.initWithItems(@outsourced_values)
    @outsourced_segmented_control.frame = CGRectMake(10, 240, 300, 30)
    @outsourced_segmented_control.selectedSegmentIndex = 0

    self.view.addSubview(@outsourced_segmented_control)


    @methodology_label = UILabel.alloc.initWithFrame(CGRectMake(10, 290, 300, 30))
    @methodology_label.text = "Methodology"
    @methodology_label.color = UIColor.colorWithRed(0.400, green: 0.400, blue: 0.400, alpha: 1.0)
    @methodology_label.backgroundColor = UIColor.clearColor
    @methodology_label.font = UIFont.fontWithName("AvenirNext-DemiBold", size: 20)
    @methodology_label.textAlignment = UITextAlignmentCenter

    self.view.addSubview(@methodology_label)


    @methodology_values = NSMutableArray.alloc.init
    @methodology_values.addObject("Waterfall")
    @methodology_values.addObject("Agile")

    @methodology_segmented_control = UISegmentedControl.alloc.initWithItems(@methodology_values)
    @methodology_segmented_control.frame = CGRectMake(10, 320, 300, 30)
    @methodology_segmented_control.selectedSegmentIndex = 0

    self.view.addSubview(@methodology_segmented_control)


    # This control initialization is radically different from the other ones, this is because
    # UIButton provides different types and styles of buttons. The default one is Rounded Rect
    @estimate_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    @estimate_button.frame = CGRectMake(10, 400, 300, 40)

    # Sometimes when we work with controls we can change the title or image based on different states of
    # it. (Normal, Selected, Highlighted)
    @estimate_button.setBackgroundImage(UIImage.imageNamed("btnEstimate.png"), forState:UIControlStateNormal)
    #@estimate_button.setTitle("Estimate this project", forState: UIControlStateNormal)

    # Lets tell the button who is going to call and where, when the user touch it
    @estimate_button.addTarget(self,
                               action: "estimate_project:",
                               forControlEvents: UIControlEventTouchUpInside)

    self.view.addSubview(@estimate_button)
  end


  def textFieldShouldReturn(textField)

    textField.resignFirstResponder

    true
  end


  def estimate_project(sender)

    # Create a new instance of Project
    project = Project.new

    project.number_of_screens = @number_of_screens_text_field.text.intValue


    # We need the selected index to extract the string value from the segmented allowed
    # values array
    selected_complexity_index = @complexity_segmented_control.selectedSegmentIndex
    project.complexity = @complexity_values.objectAtIndex(selected_complexity_index)


    selected_outsourced_index = @outsourced_segmented_control.selectedSegmentIndex
    project.outsourced = @outsourced_values.objectAtIndex(selected_outsourced_index)


    selected_methodology_index = @methodology_segmented_control.selectedSegmentIndex
    project.methodology = @methodology_values.objectAtIndex(selected_methodology_index)


    project.estimate


    # Now we need a new instance of the Estimation View Controller for show the
    # results of the Project estimation
    @estimation_view_controller = EstimationViewController.alloc.init

    @estimation_view_controller.view.frame = self.view.frame

    # Lets tell it to bind our project instance
    @estimation_view_controller.bind_project(project)


    # To show the Estimation View Controller view, we can use a transition.
    # From our current view, to the Estimation View Controller's view
    UIView.transitionFromView(self.view,
                              toView: @estimation_view_controller.view,
                              duration: 0.3,
                              options: UIViewAnimationOptionTransitionFlipFromLeft,
                              completion: nil)

  end

end
