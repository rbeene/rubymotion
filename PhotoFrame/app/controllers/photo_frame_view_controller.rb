class PhotoFrameViewController < UIViewController
  include PhotoViewUtilities

  def viewDidLoad
    UIApplication.sharedApplication.setStatusBarHidden(true ,animated:false)
    view.backgroundColor = UIColor.lightGrayColor
    @imageView           = photoUIImageView
    @frameView           = frameUIImageView
    view.addSubview(@frameView)
    view.addSubview(@imageView)
    registerDeviceNotification
  end

  def orientationChanged(notification)
    p notification.object.batteryLevel
    deviceOrientation = notification.object.orientation
    if deviceOrientation == UIDeviceOrientationLandscapeLeft || deviceOrientation == UIDeviceOrientationLandscapeRight
      @imageView.frame = CGRectMake(20,20, 440, 260)
    else
      @imageView.frame = CGRectMake(20,20, 280, 420)
    end
  end

  def batteryLevelChanged(notification)
    p notification.object.batteryLevel
  end


  def registerDeviceNotification
    # Get the device object
    device = UIDevice.currentDevice
    device.batteryMonitoringEnabled = true
    # Tell it to start monitoring the accelerometer for orientation
    # Get the notification center for the app
    nc = NSNotificationCenter.defaultCenter
    # Add yourself as an observer
    nc.addObserver(self, selector: :'batteryLevelChanged:', name:UIDeviceBatteryLevelDidChangeNotification, object:device)
  end
end