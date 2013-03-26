class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
   
    #Create an instance of Layer View Controller
    layer_view_controller = LayerViewController.alloc.init

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    #Every window has a root view controller from which it will present its view
    @window.rootViewController = layer_view_controller
    @window.makeKeyAndVisible
    true
  end

end
