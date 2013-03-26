class PhotoFrameViewController < UIViewController

  def orientationChanged(notification)
  	deviceOrientation = notification.object.orientation
    if deviceOrientation == UIDeviceOrientationLandscapeLeft || deviceOrientation == UIDeviceOrientationLandscapeRight
    	
    	@imageView.frame = CGRectMake(20,20, 440, 260)
  
    else
    	@imageView.frame = CGRectMake(20,20, 280, 420)
    end
  end
   
  def registerDeviceNotification
  	# Get the device object
    device = UIDevice.currentDevice
    # Tell it to start monitoring the accelerometer for orientation
    device.beginGeneratingDeviceOrientationNotifications
    # Get the notification center for the app
    nc = NSNotificationCenter.defaultCenter
    # Add yourself as an observer
    nc.addObserver(self, selector: :'orientationChanged:',name:UIDeviceOrientationDidChangeNotification ,object:device)
  end

  def shouldAutorotateToInterfaceOrientation(interfaceOrientation)
    # Return YES if incoming orientation is Portrait
    #  or either of the Landscapes, otherwise, return NO
    shouldRotate = NO
    if (interfaceOrientation == UIInterfaceOrientationPortrait) || UIInterfaceOrientationIsLandscape(interfaceOrientation)
      shouldRotate = YES    
    end 
    shouldRotate 
  end
    
	def viewDidLoad
    UIApplication.sharedApplication.setStatusBarHidden(true ,animated:false)
  	@imageView = photoUIImageView;
    frameView = frameUIImageView;
    view.addSubview(frameView)
  	view.addSubview(@imageView)
  end		
end