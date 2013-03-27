module PhotoViewUtilities
  def photoUIImageView
    image = UIImage.imageNamed('me')
    photo_view = UIImageView.alloc.initWithImage(image)
    photo_view.frame = CGRectMake(20,20, 280, 420)
    photo_view.setAutoresizingMask(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
    photo_view
  end

  def frameUIImageView
    image = UIImage.imageNamed("frame.png")
    photoView = UIImageView.alloc.initWithImage(image)
    photoView.frame =  CGRectMake(0,0, 320, 460)
    photoView.setAutoresizingMask(UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight)
    photoView
  end
end