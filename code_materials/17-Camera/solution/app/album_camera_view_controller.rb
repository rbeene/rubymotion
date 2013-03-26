class CameraViewController < UIViewController

  CHOOSE_BUTTON_TAG = 1 
  TAKE_BUTTON_TAG = 2
  IMAGE_VIEW_TAG = 3
  
  
	def loadView
    views = NSBundle.mainBundle.loadNibNamed "CameraView", owner:self, options:nil
    #Assign the first View from the nib file
  	self.view = views[0]
  	styleNavigationBar
    bindGraphicElements				
	end

  def choosePicture(sender)
    imagePicker = UIImagePickerController.alloc.init
    #pick from photo library
    imagePicker.setSourceType(UIImagePickerControllerSourceTypePhotoLibrary)
    imagePicker.delegate = self
    self.presentViewController(imagePicker,animated:true, completion:nil)
  end

  def takePicture(sender)
    imagePicker = UIImagePickerController.alloc.init

    #ask if camera is avalaible
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceTypeCamera)
       #pick from photo camera
      imagePicker.setSourceType(UIImagePickerControllerSourceTypeCamera)
      imagePicker.delegate = self
      self.presentViewController(imagePicker,animated:true, completion:nil)
    else
      puts "Unavalaible"
    end 
  end

  def bindGraphicElements
    @chooseButton =  self.view.viewWithTag( CHOOSE_BUTTON_TAG )
    @chooseButton.addTarget(self, action: :'choosePicture:',forControlEvents:UIControlEventTouchUpInside)
    @takeButton =  self.view.viewWithTag( TAKE_BUTTON_TAG )
    @takeButton.addTarget(self, action: :'takePicture:',forControlEvents:UIControlEventTouchUpInside)
    @imageView = self.view.viewWithTag( IMAGE_VIEW_TAG )
    choose_button = self.view.viewWithTag(CHOOSE_BUTTON_TAG)
    select_button = self.view.viewWithTag(TAKE_BUTTON_TAG)
    choose_button.setImage (UIImage.imageNamed("icnChoose.png"),forState:UIControlStateNormal)  
    select_button.setImage (UIImage.imageNamed("icnTake.png"),forState:UIControlStateNormal)  
  end

  # UIImagePickerController Delegate

  def imagePickerController(picker, didFinishPickingMediaWithInfo:info)
    #Get picked image from info dictionary
    image = info.objectForKey(UIImagePickerControllerOriginalImage)
    #Put that image onto the screen in our image view
    @imageView.image = image
    #You must call this dismiss method
    self.dismissViewControllerAnimated(true,completion:nil)
    
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