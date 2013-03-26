class CameraViewController < UIViewController
  
  CHOOSE_BUTTON = 1
  SELECT_BUTTON = 2

	def loadView
    views = NSBundle.mainBundle.loadNibNamed "CameraView", owner:self, options:nil
    #Assign the first View from the nib file
  	self.view = views[0]
  	styleNavigationBar
    choose_button = self.view.viewWithTag(CHOOSE_BUTTON)
    select_button = self.view.viewWithTag(SELECT_BUTTON)
    choose_button.setImage (UIImage.imageNamed("icnChoose.png"),forState:UIControlStateNormal)	
    select_button.setImage (UIImage.imageNamed("icnTake.png"),forState:UIControlStateNormal)  
	end

	def viewDidLoad
    super()
    self.view.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bgTile"))
  end
	
	def viewDidDisappear(animated)
    @buttonWithImage.addTarget(self, action: :'showMenu:',forControlEvents:UIControlEventTouchUpInside)
  end

  def showMenu(sender)
    frameView = self.navigationController.view.frame
    frameView.origin.x = 78
    self.navigationController.view.frame = frameView
    @buttonWithImage.addTarget(self, action: :'hideMenu:',forControlEvents:UIControlEventTouchUpInside) 
  end

  def hideMenu(sender)
    frameView = self.navigationController.view.frame
    frameView.origin.x = 0
    self.navigationController.view.frame = frameView
    @buttonWithImage.addTarget(self, action: :'showMenu:',forControlEvents:UIControlEventTouchUpInside) 
  end  

  def styleNavigationBar
    self.navigationController.navigationBar.setBackgroundImage UIImage.imageNamed("navBar.png") ,forBarMetrics: UIToolbarPositionAny
    @buttonWithImage = menuButtonItem
    @buttonWithImage.addTarget(self, action: :'showMenu:',forControlEvents:UIControlEventTouchUpInside)
    barButton = UIBarButtonItem.alloc.initWithCustomView(@buttonWithImage)
    self.navigationItem.leftBarButtonItem = barButton 
  end

end