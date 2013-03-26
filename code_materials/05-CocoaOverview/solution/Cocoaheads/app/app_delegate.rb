class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    next_event_view_controller = NextEventViewController.alloc.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = next_event_view_controller
    @window.makeKeyAndVisible
    true
  end
  
end
