class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)

    return true if RUBYMOTION_ENV == 'test'
    event_detail_view_controller = EventDetailViewController.alloc.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = event_detail_view_controller
    @window.makeKeyAndVisible
    true
  end
end
