class PhotoViewController < UIViewController

  def loadView

    # Create a new view for our controller and add a nice
    # background color
    self.view = UIView.alloc.init

    # Add a Background Image for the app using a UIImageView
    background_view = UIImageView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    background_view.image = UIImage.imageNamed("bgBackground.png")
    self.view.addSubview(background_view)

    # Create a new UIPanGestureRecognizer to detect the 
    # user drag on the view
    pan_gesture_recognizer = UIPanGestureRecognizer.alloc.initWithTarget(self, 
                                                                         action:'pan_gesture_was_recognizer:')

    # Add the Pan Gesture Recognizer to the controller
    # view
    self.view.addGestureRecognizer(pan_gesture_recognizer)


    # Create a new instance of the Photo Filter Controller
    @photo_filter_controller = PhotoFilterController.new

    # Create a new NSOperationQueue for excecuting the
    # filter intensity changes
    @filter_intensity_queue = NSOperationQueue.new


    # Layout four buttons for the user to select
    # the Photo Filters
    layout_filter_buttons

    # Layout an image view for us to draw the user
    # selected image
    layout_photo_image_view

    # Layout an activity indicator that will tell the
    # user that we are working on something
    layout_activity_indicator

    # Layout the image picker for the user to take
    # or select a photo
    layout_image_picker_controller
  end


  # Pan Gesture Recognizer Callback
  def pan_gesture_was_recognizer(pan_gesture_recognizer)

    # We need the velocity of the gesture to determinate
    # de direction of the touch drag
    gesture_velocity = pan_gesture_recognizer.velocityInView(self.view)

    # If the velocity is less than cero means that the
    # user is dragging up
    if(gesture_velocity.y < 0)

      # Create a NSInvocationOperation that will allow us to run some method
      # on another thread
      increase_image_filter_operation = NSInvocationOperation.alloc.initWithTarget(self, 
                                                                                   selector:'increase_image_filter', 
                                                                                   object:nil)

      # Add the Invocation Operation to the NSOperationQueue
      @filter_intensity_queue.addOperation(increase_image_filter_operation)

    # And if the velocity is more than cero, the user
    # is dragging down
    else

      # Create a NSInvocationOperation that will allow us to run some method
      # on another thread
      increase_image_filter_operation = NSInvocationOperation.alloc.initWithTarget(self, 
                                                                                   selector:'decrease_image_filter', 
                                                                                   object:nil)

      # Add the Invocation Operation to the NSOperationQueue
      @filter_intensity_queue.addOperation(increase_image_filter_operation)

    end

  end


  def increase_image_filter

    # Start the activity animator
    @activity_indicator.performSelectorOnMainThread('startAnimating', withObject:nil, waitUntilDone:false)

    # Generate the Filtered Image
    filtered_image = @photo_filter_controller.filtered_image_with_increased_intensity(@selected_image)

    # Excecute the change of the image in the Photo Image View on the Main Thread
    @photo_image_view.performSelectorOnMainThread('setImage:', withObject:filtered_image, waitUntilDone:false)

    # Stop the activity animator
    @activity_indicator.performSelectorOnMainThread('stopAnimating', withObject:nil, waitUntilDone:false)
  end


  def decrease_image_filter

    # Start the activity animator
    @activity_indicator.performSelectorOnMainThread('startAnimating', withObject:nil, waitUntilDone:false)

    # Generate the Filtered Image
    filtered_image = @photo_filter_controller.filtered_image_with_decreased_intensity(@selected_image)

    # Excecute the change of the image in the Photo Image View on the Main Thread
    @photo_image_view.performSelectorOnMainThread('setImage:', withObject:filtered_image, waitUntilDone:false)

    # Stop the activity animator
    @activity_indicator.performSelectorOnMainThread('stopAnimating', withObject:nil, waitUntilDone:false)
  end


  def layout_filter_buttons

    # First button for the Pixellate Filter
    pixellate_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    pixellate_button.frame = CGRectMake(10, 385, 75, 65)
    pixellate_button.setBackgroundImage(UIImage.imageNamed('bgPixellateDisabled.png'), forState:UIControlStateNormal)
    pixellate_button.setBackgroundImage(UIImage.imageNamed('bgPixellateEnabled.png'), forState:UIControlStateHighlighted)

    pixellate_button.addTarget(self, 
                               action:'add_pixellate_filter', 
                               forControlEvents:UIControlEventTouchUpInside)

    self.view.addSubview(pixellate_button)


    # Second button for the Sepia Filter
    sepia_tone_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    sepia_tone_button.frame = CGRectMake(85, 385, 75, 65)
    sepia_tone_button.setBackgroundImage(UIImage.imageNamed('bgSepiaDisabled.png'), forState:UIControlStateNormal)
    sepia_tone_button.setBackgroundImage(UIImage.imageNamed('bgSepiaEnabled.png'), forState:UIControlStateHighlighted)

    sepia_tone_button.addTarget(self, 
                                action:'add_sepia_tone_filter', 
                                forControlEvents:UIControlEventTouchUpInside)

    self.view.addSubview(sepia_tone_button)


    # Third button for Color Monochrome Filter
    color_monochrome_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    color_monochrome_button.frame = CGRectMake(160, 385, 75, 65)
    color_monochrome_button.setBackgroundImage(UIImage.imageNamed('bgMonocolorDisabled.png'), forState:UIControlStateNormal)
    color_monochrome_button.setBackgroundImage(UIImage.imageNamed('bgMonocolorEnabled.png'), forState:UIControlStateHighlighted)

    color_monochrome_button.addTarget(self, 
                                      action:'add_color_monochrome_filter', 
                                      forControlEvents:UIControlEventTouchUpInside)

    self.view.addSubview(color_monochrome_button)


    # Fourth button for Gaussian Blur Filter
    gaussian_blur_button = UIButton.buttonWithType(UIButtonTypeRoundedRect)
    gaussian_blur_button.frame = CGRectMake(235, 385, 75, 65)
    gaussian_blur_button.setBackgroundImage(UIImage.imageNamed('bgBlurDisabled.png'), forState:UIControlStateNormal)
    gaussian_blur_button.setBackgroundImage(UIImage.imageNamed('bgBlurEnabled.png'), forState:UIControlStateHighlighted)

    gaussian_blur_button.addTarget(self, 
                                   action:'add_gaussian_blur_filter', 
                                   forControlEvents:UIControlEventTouchUpInside)

    self.view.addSubview(gaussian_blur_button)
  end


  def layout_activity_indicator

    # Create a new instance of the UIActivityIndicator View
    @activity_indicator = UIActivityIndicatorView.alloc.initWithActivityIndicatorStyle(UIActivityIndicatorViewStyleWhiteLarge)

    # Set the center as the same of the Photo Image View
    @activity_indicator.center = @photo_image_view.center

    # Set some properties like the color and that we need to
    # hide when its not animating
    @activity_indicator.color = UIColor.colorWithRed(0.400, green:0.400, blue:0.431, alpha:1.0)
    @activity_indicator.hidesWhenStopped = true

    # Add the activity indicator to our view
    self.view.addSubview(@activity_indicator)
  end


  # Pixellate Filter Button Callback
  def add_pixellate_filter

    # Start the activity animator
    @activity_indicator.startAnimating

    # Get a GCD Queue in this case a High one, but the options are
    # :high, :low, :default, :default
    high_priority_queue = Dispatch::Queue.concurrent(priority=:high) 

    # Send a block to be executed asynchronously on the High Priority
    # Queue
    #
    # The code inside the block will be run in another thread
    high_priority_queue.async {

      # Generate the Filtered Image
      filtered_image = @photo_filter_controller.image_for_filter(:pixellate,
                                                                 @selected_image,
                                                                 8.0)

                                                                 # We need to excecute the Photo Image View change on the 
                                                                 # main thread, because we are modifying the User Interface
                                                                 #
                                                                 # For this we can also use GCD getting the Main Thread queue,
                                                                 # remember we are running on another thread
                                                                 main_queue = Dispatch::Queue.main

                                                                 # Now we can excecute any code on the Main Thread using the Main
                                                                 # Queue
                                                                 main_queue.async {

                                                                   # Set the Filtered Image to our Photo Image View
                                                                   @photo_image_view.image = filtered_image

                                                                   # Stop the activity animator
                                                                   @activity_indicator.stopAnimating
                                                                 }
    }
  end

  # Sepia Tone Filter Button Callback
  def add_sepia_tone_filter

    # Start the activity animator
    @activity_indicator.startAnimating

    # Get a GCD Queue in this case a High one, but the options are
    # :high, :low, :default, :default
    high_priority_queue = Dispatch::Queue.concurrent(priority=:high) 

    # Send a block to be executed asynchronously on the High Priority
    # Queue
    #
    # The code inside the block will be run in another thread
    high_priority_queue.async {

      # Generate the Filtered Image
      filtered_image = @photo_filter_controller.image_for_filter(:sepia_tone,
                                                                 @selected_image,
                                                                 8.0)

                                                                 # We need to excecute the Photo Image View change on the 
                                                                 # main thread, because we are modifying the User Interface
                                                                 #
                                                                 # For this we can also use GCD getting the Main Thread queue,
                                                                 # remember we are running on another thread
                                                                 main_queue = Dispatch::Queue.main

                                                                 # Now we can excecute any code on the Main Thread using the Main
                                                                 # Queue
                                                                 main_queue.async {

                                                                   # Set the Filtered Image to our Photo Image View
                                                                   @photo_image_view.image = filtered_image

                                                                   # Stop the activity animator
                                                                   @activity_indicator.stopAnimating
                                                                 }
    }
  end

  # Color Monochrome Filter Button Callback
  def add_color_monochrome_filter

    # Start the activity animator
    @activity_indicator.startAnimating

    # Get a GCD Queue in this case a High one, but the options are
    # :high, :low, :default, :default
    high_priority_queue = Dispatch::Queue.concurrent(priority=:high) 

    # Send a block to be executed asynchronously on the High Priority
    # Queue
    #
    # The code inside the block will be run in another thread
    high_priority_queue.async {

      # Generate the Filtered Image
      filtered_image = @photo_filter_controller.image_for_filter(:color_monochrome,
                                                                 @selected_image,
                                                                 8.0)

                                                                 # We need to excecute the Photo Image View change on the 
                                                                 # main thread, because we are modifying the User Interface
                                                                 #
                                                                 # For this we can also use GCD getting the Main Thread queue,
                                                                 # remember we are running on another thread
                                                                 main_queue = Dispatch::Queue.main

                                                                 # Now we can excecute any code on the Main Thread using the Main
                                                                 # Queue
                                                                 main_queue.async {

                                                                   # Set the Filtered Image to our Photo Image View
                                                                   @photo_image_view.image = filtered_image

                                                                   # Stop the activity animator
                                                                   @activity_indicator.stopAnimating
                                                                 }
    }
  end

  # Gaussian Blur Filter Button Callback
  def add_gaussian_blur_filter

    # Start the activity animator
    @activity_indicator.startAnimating

    # Get a GCD Queue in this case a High one, but the options are
    # :high, :low, :default, :default
    high_priority_queue = Dispatch::Queue.concurrent(priority=:high) 

    # Send a block to be executed asynchronously on the High Priority
    # Queue
    #
    # The code inside the block will be run in another thread
    high_priority_queue.async {

      # Generate the Filtered Image
      filtered_image = @photo_filter_controller.image_for_filter(:gaussian_blur,
                                                                 @selected_image,
                                                                 8.0)

                                                                 # We need to excecute the Photo Image View change on the 
                                                                 # main thread, because we are modifying the User Interface
                                                                 #
                                                                 # For this we can also use GCD getting the Main Thread queue,
                                                                 # remember we are running on another thread
                                                                 main_queue = Dispatch::Queue.main

                                                                 # Now we can excecute any code on the Main Thread using the Main
                                                                 # Queue
                                                                 main_queue.async {

                                                                   # Set the Filtered Image to our Photo Image View
                                                                   @photo_image_view.image = filtered_image

                                                                   # Stop the activity animator
                                                                   @activity_indicator.stopAnimating
                                                                 }
    }
  end


  # Image Picker Controller callback, this method is invoked
  # when the user selects an image
  def imagePickerController(picker, didFinishPickingMediaWithInfo: info)

    # Remove the Image Picker from our Controller View
    @image_picker_controller.view.removeFromSuperview

    # Save the user selected image
    @selected_image = info.objectForKey(UIImagePickerControllerOriginalImage)

    # Add the user selected image to our photo image view
    @photo_image_view.image = @selected_image 
  end



  def layout_photo_image_view

    # Instance a new UIImageView to create a frame for the 
    # photo image view
    photo_image_view_frame = UIImageView.alloc.initWithFrame(CGRectMake(12.5, 20, 295, 355))
    photo_image_view_frame.image = UIImage.imageNamed("bgPhotoFrame.png")
    
    self.view.addSubview(photo_image_view_frame)

    # Create a new instance of a UIViewController named 
    # photo_image_view and for avoiding that the image will look
    # streched set its content mode to UIViewContentModeScaleAspectFill
    @photo_image_view = UIImageView.alloc.initWithFrame(CGRectMake(30, 41, 260, 316))
    @photo_image_view.backgroundColor = UIColor.clearColor
    @photo_image_view.contentMode = UIViewContentModeScaleAspectFill;
    @photo_image_view.clipsToBounds = true;


    # Add the photo image view to the controller view
    self.view.addSubview(@photo_image_view)
  end


  def layout_image_picker_controller

    # We need a instance of the UIImagePickerController
    @image_picker_controller = UIImagePickerController.alloc.init


    # For this to work on the simulator we need to ask the
    # UIImagePickerController if we have a camera available
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceTypeCamera)

      # If we have a camera lets use it
      @image_picker_controller.setSourceType(UIImagePickerControllerSourceTypeCamera)

    else

      # If we don't lets present the Photo Library
      @image_picker_controller.setSourceType(UIImagePickerControllerSourceTypePhotoLibrary)

    end


    # Set the frame of the Picker Controller to the same
    # as our controller view
    @image_picker_controller.view.frame = self.view.bounds

    # Assign the controller as a delegate of the Image
    # Picker
    @image_picker_controller.delegate = self

    # Add the Image Picker view as subview of our controller
    # view
    self.view.addSubview(@image_picker_controller.view)
  end

end
