class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    project_view_controller = ProjectViewController.alloc.init
    @window                 = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    #Every window has a root view controller from which it will present its view
    @window.rootViewController = project_view_controller
    @window.makeKeyAndVisible

    true
  end
end
