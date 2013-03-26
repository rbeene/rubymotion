class LayerViewController < UIViewController

  def loadView

    # Lets create a view for our view controller
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Instantiate a gesture recognizer to handle the user touch
    tap_gesture_recognizer = UITapGestureRecognizer.alloc.initWithTarget(self,
                                                                         action:'view_tap:')

    self.view.addGestureRecognizer(tap_gesture_recognizer)

    layout_background_layer
    layout_sun_layer
    layout_grass_layer
  end


  def view_tap(tap_gesture_recognizer)

    #Get the position of the touch according to the view
    tap_point_in_view = tap_gesture_recognizer.locationInView(self.view)

    #Apply the position to our Sun Layer
    @sun_layer.position = tap_point_in_view

  end

  def layout_background_layer

    # We need a new type of layer used to create Gradients
    background_layer = CAGradientLayer.layer
    background_layer.frame = self.view.bounds

    # Initialize the colors of the gradient, it can have any number of colors
    # in this case we will use only three
    top_background_color = UIColor.colorWithRed(0.131, green:0.387, blue:0.618, alpha:1.0).CGColor
    middle_background_color = UIColor.colorWithRed(0.255, green:0.686, blue:0.984, alpha:1.0).CGColor
    bottom_background_color = UIColor.colorWithRed(0.367, green:0.692, blue:1.0, alpha:1.0).CGColor

    # Set the colors in the layer using an array
    background_layer.colors = NSArray.arrayWithObjects(top_background_color,
                                                       middle_background_color,
                                                       bottom_background_color,
                                                       nil)

    # Set the colors locations into the array, this means where it will start painting
    # the color, if you look closely we are telling the layer to paint the top color in
    # 0.0 which is the top, the middle in 0.5 and 0.0 for the bottom color
    background_layer.locations = NSArray.arrayWithObjects(NSNumber.numberWithFloat(0.0),
                                                          NSNumber.numberWithFloat(0.5),
                                                          NSNumber.numberWithFloat(1.0),
                                                          nil)

    # We want this layer to be the background of our app    
    self.view.layer.insertSublayer(background_layer, atIndex:0)
  end


  def layout_grass_layer

    #Lets instance a new layer for containing our grass image
    grass_layer = CALayer.layer
    grass_layer.frame = self.view.bounds

    #Load the image into memory
    grassImage = UIImage.imageNamed("bgGrass.png")

    # Set the image as content of the layer
    grass_layer.contents = grassImage.CGImage

    self.view.layer.addSublayer(grass_layer)
  end


  def layout_sun_layer

    # Create a new type of layer, in this case CAShapeLayer
    @sun_layer = CAShapeLayer.layer
    @sun_layer.frame = CGRectMake(0, 0, 150, 150)
    @sun_layer.position = CGPointMake(50, 50)

    # Set some color for the figure fill and the stroke
    @sun_layer.fillColor = UIColor.colorWithRed(0.957, green:0.824, blue:0.184, alpha:1.0).CGColor
    @sun_layer.strokeColor = UIColor.colorWithRed(0.988, green:0.604, blue:0.153, alpha:1.0).CGColor

    # We need to set a line width of 10 for this particular figure
    @sun_layer.lineWidth = 10


    # The following part is the path that composes the figure
    # point by point into the layer
    sun_path = UIBezierPath.bezierPath

    sun_path.moveToPoint(CGPointMake(91.15, 48.53))
    sun_path.addLineToPoint(CGPointMake(91.15, 48.53))
    sun_path.addLineToPoint(CGPointMake(106.00, 41.88))
    sun_path.addLineToPoint(CGPointMake(114.90, 55.50))
    sun_path.addLineToPoint(CGPointMake(130.99, 57.94))
    sun_path.addLineToPoint(CGPointMake(131.11, 74.21))
    sun_path.addLineToPoint(CGPointMake(143.33, 84.95))
    sun_path.addLineToPoint(CGPointMake(134.63, 98.71))
    sun_path.addLineToPoint(CGPointMake(139.10, 114.35))
    sun_path.addLineToPoint(CGPointMake(124.35, 121.22))
    sun_path.addLineToPoint(CGPointMake(119.65, 136.80))
    sun_path.addLineToPoint(CGPointMake(103.53, 134.60))
    sun_path.addLineToPoint(CGPointMake(91.15, 145.17))
    sun_path.addLineToPoint(CGPointMake(78.78, 134.60))
    sun_path.addLineToPoint(CGPointMake(62.66, 136.80))
    sun_path.addLineToPoint(CGPointMake(57.96, 121.22))
    sun_path.addLineToPoint(CGPointMake(43.21, 114.35))
    sun_path.addLineToPoint(CGPointMake(47.68, 98.71))
    sun_path.addLineToPoint(CGPointMake(38.98, 84.95))
    sun_path.addLineToPoint(CGPointMake(51.20, 74.21))
    sun_path.addLineToPoint(CGPointMake(51.32, 57.94))
    sun_path.addLineToPoint(CGPointMake(67.41, 55.50))
    sun_path.addLineToPoint(CGPointMake(76.31, 41.88))

    sun_path.closePath

    # Set the path into the layer
    @sun_layer.path = sun_path.CGPath;

    self.view.layer.addSublayer(@sun_layer)
  end
end
