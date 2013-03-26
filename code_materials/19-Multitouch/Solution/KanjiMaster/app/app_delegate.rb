class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)
    
    #Create an instance of Kanji View Controller
    kanji_view_controller = KanjiViewController.alloc.init

    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    #Every window has a root view controller from which it will present its view
    @window.rootViewController = kanji_view_controller
    @window.makeKeyAndVisible

    true
  end

end
