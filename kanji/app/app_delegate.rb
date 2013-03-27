class AppDelegate
  def application(application, didFinishLaunchingWithOptions:launchOptions)
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    kanji_view_controller = KanjiViewController.alloc.init
    @window.rootViewController = kanji_view_controller
    @window.makeKeyAndVisible
    true
  end
end
