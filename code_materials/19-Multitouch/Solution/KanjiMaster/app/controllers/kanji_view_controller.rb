class KanjiViewController < UIViewController

  def loadView

    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Create a new UIImageView to draw our background image
    background_image_view = UIImageView.alloc.initWithFrame(self.view.bounds)

    # Set our background image into the UIImageView
    background_image_view.image = UIImage.imageNamed("bgKanji.png")

    # Add the UIImageView instance into the view
    self.view.addSubview(background_image_view)

    # Load our custom UIView (KanjiView)
    kanjiView = KanjiView.alloc.initWithFrame(self.view.bounds)

    # Add it to our view controller's view 
    self.view.addSubview(kanjiView)
  end

end
