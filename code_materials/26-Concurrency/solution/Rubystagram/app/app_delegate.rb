class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    #Create an instance of Photo View Controller
    photo_view_controller = PhotoViewController.alloc.init

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    #Every window has a root view controller from which it will present its view
    @window.rootViewController = photo_view_controller
    @window.makeKeyAndVisible

    true
  end

end
