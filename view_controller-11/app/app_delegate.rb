
class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    return true if RUBYMOTION_ENV == 'test'
    #next_event_view_controller = NextEventViewController.alloc.init
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = appTabBarController
    @window.makeKeyAndVisible
    true
  end

  def appTabBarController
    tab_bar_controller = UITabBarController.alloc.init
    tab_bar_controller.viewControllers = [
      CalendarViewController.alloc.init,
      NextEventViewController.alloc.init,
      NewsViewController.alloc.init
    ]
    tab_bar_controller.tabBar.backgroundImage = UIImage.imageNamed "bgTabBar"
    tab_bar_controller.selectedIndex = 1
    tab_bar_controller
  end

end
