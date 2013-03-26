def photoUIImageView
  image = UIImage.imageNamed("me.png")
	photoView = UIImageView.alloc.initWithImage(image)
	photoView.frame =  CGRectMake(20,20, 280, 420)
	photoView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
  photoView
end

def frameUIImageView
  image = UIImage.imageNamed("frame.png")
  photoView = UIImageView.alloc.initWithImage(image)
  photoView.frame =  CGRectMake(0,0, 320, 460)
  photoView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
  photoView
end

def menuButtonItem
  buttonWithImage = UIButton.buttonWithType UIButtonTypeCustom
  buttonWithImage.setFrame CGRectMake(0.0, 0.0, 40.0, 35.0)
  buttonWithImage.setImage UIImage.imageNamed("icnMenuEnabled"), forState:UIControlStateSelected
  buttonWithImage.setImage UIImage.imageNamed("icnMenuEnabled"), forState:UIControlStateHighlighted
  buttonWithImage.setImage UIImage.imageNamed("icnMenuDisabled"), forState:UIControlStateNormal
  buttonWithImage
end

def saveButtonItem
  buttonWithImage = UIButton.buttonWithType UIButtonTypeCustom
  buttonWithImage.setFrame CGRectMake(0.0, 0.0, 40.0, 35.0)
  buttonWithImage.setImage UIImage.imageNamed("sendEnabled"), forState:UIControlStateSelected
  buttonWithImage.setImage UIImage.imageNamed("sendEnabled"), forState:UIControlStateHighlighted
  buttonWithImage.setImage UIImage.imageNamed("sendDisabled"), forState:UIControlStateNormal
  buttonWithImage
end