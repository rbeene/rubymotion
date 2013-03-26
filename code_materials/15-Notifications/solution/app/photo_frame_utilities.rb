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