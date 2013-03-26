class NewsViewController < UIViewController
  def init
    super
    self.title = "News"
    setupTabBarItem
    self
  end

  def setupTabBarItem
    tab_bar_item = UITabBarItem.alloc.initWithTitle("", image:nil,tag:1)
    tab_bar_item.setFinishedSelectedImage(UIImage.imageNamed("icnNews"), withFinishedUnselectedImage:UIImage.imageNamed("icnNews"))
    self.tabBarItem = tab_bar_item
  end


end