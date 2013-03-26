class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    event_detail_view_controller = EventDetailViewController.alloc.init
    @window                      = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    #Every window has a root view controller from which it will present its view
    @window.rootViewController = event_detail_view_controller
    @window.makeKeyAndVisible
    true
  end
end
