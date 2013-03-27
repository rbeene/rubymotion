class LayerViewController < UIViewController
  def loadView
    self.view = UIView.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    layout_background_layer
    layout_sun_layer
    layout_grass_layer
    layout_cloud_layers
    load_sun_animation
  end

  def load_sun_animation

    # Create a new instance of CAKeyframeAnimation
    translation_animation = CAKeyframeAnimation.animationWithKeyPath('position')

    # Set the animation duration
    translation_animation.duration = 15


    # Using a BezierPath we will create the Arc for the position
    # animation to cover, is better this way using lines and curves
    # than setting every point by ourselfs
    sun_path = UIBezierPath.bezierPath
    sun_path.moveToPoint(CGPointMake(-90, 660))
    sun_path.addCurveToPoint(CGPointMake(410, 660),
                             controlPoint1:CGPointMake(90, -100),
                             controlPoint2:CGPointMake(230, -100))


    # Assign the path to the animation
    translation_animation.path = sun_path.CGPath

    # Because we want a infinite animation we set the repeat count to Float Max
    translation_animation.repeatCount = Float::MAX

    # Apply the timing function to simulate the Easy out Easing
    translation_animation.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseInEaseOut)

    @sun_layer.addAnimation(translation_animation, forKey:'position_animation')

    # Create another instance of the CABasicAnimation with the property 'transform.rotation.z'
    # this property allows us to change the layer in any of the three dimensions, in this case
    # y axis
    rotation_animation = CABasicAnimation.animationWithKeyPath('transform.rotation.z')

    # Take a note here we are setting 360 degrees, but Core Animation works with radians
    # thats why the conversion PI * 2
    rotation_animation.toValue = NSNumber.numberWithFloat(Math::PI * 2)

    # Set the duration according with the other animation
    rotation_animation.duration = 5

    # Because we want a infinite animation we set the repeat count to Float Max
    rotation_animation.repeatCount = Float::MAX

    # Add the animation to the layer
    @sun_layer.addAnimation(rotation_animation, forKey:'rotation_animation')
  end

  def layout_cloud_layers

    # Lets instance a new layer for our first cloud image
    first_cloud_layer = CALayer.layer
    first_cloud_layer.frame = CGRectMake(0, 0, 153, 82)
    first_cloud_layer.position = CGPointMake(-153, 170)

    # Load the image into memory
    first_cloud_image = UIImage.imageNamed("bgCloud1.png")

    # Set the image as content of the layer
    first_cloud_layer.contents = first_cloud_image.CGImage

    self.view.layer.addSublayer(first_cloud_layer)


    # Instanciate a new animation for the first cloud move
    first_cloud_animation = CABasicAnimation.animationWithKeyPath('position')

     # Set the animation duration
    first_cloud_animation.duration = 7

    # We need to set the initial value of the animation and the final one
    first_cloud_animation.fromValue = NSValue.valueWithCGPoint(first_cloud_layer.position)

    # Final position for the first cloud
    first_cloud_final_position = CGPointMake(473, 170)

    first_cloud_animation.toValue = NSValue.valueWithCGPoint(first_cloud_final_position)

    # Because we want a infinite animation we set the repeat count to Float Max
    first_cloud_animation.repeatCount = Float::MAX

     # Apply the timing function to simulate the Easy out Easing
    first_cloud_animation.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseOut)

    first_cloud_layer.addAnimation(first_cloud_animation, forKey:'position_animation')



    # New layer for our second cloud image
    second_cloud_layer = CALayer.layer
    second_cloud_layer.frame = CGRectMake(0, 0, 185, 96)
    second_cloud_layer.position = CGPointMake(-185, 130)

    second_cloud_image = UIImage.imageNamed("bgCloud2.png")

    second_cloud_layer.contents = second_cloud_image.CGImage

    self.view.layer.addSublayer(second_cloud_layer)


    # Instanciate a new animation for the second cloud move
    second_cloud_animation = CABasicAnimation.animationWithKeyPath('position')

    # Set the animation duration
    second_cloud_animation.duration = 5

    # We need to set the initial value of the animation and the final one
    second_cloud_animation.fromValue = NSValue.valueWithCGPoint(first_cloud_layer.position)

    # Final position for the second cloud
    second_cloud_final_position = CGPointMake(505, 130)

    second_cloud_animation.toValue = NSValue.valueWithCGPoint(second_cloud_final_position)

    # Because we want a infinite animation we set the repeat count to Float Max
    second_cloud_animation.repeatCount = Float::MAX

    # Apply the timing function to simulate the Easy out Easing
    second_cloud_animation.timingFunction = CAMediaTimingFunction.functionWithName(KCAMediaTimingFunctionEaseOut)

    second_cloud_layer.addAnimation(second_cloud_animation, forKey:'position_animation')
  end


  def view_tap(tap_gesture_recognizer)

    #Get the position of the touch according to the view
    tap_point_in_view = tap_gesture_recognizer.locationInView(self.view)
    translation_animation = CABasicAnimation.animationWithKeyPath('position')

    # Set the animation duration
    translation_animation.duration = 1

    # We need to set the initial value of the animation and the final one
    translation_animation.fromValue = NSValue.valueWithCGPoint(@sun_layer.position)
    translation_animation.toValue = NSValue.valueWithCGPoint(tap_point_in_view)


    # Change the layer property that we want to be animated, the position of
    # this line is important. It must be before the addAnimation message.
    @sun_layer.position = tap_point_in_view

    # Add the animation to the layer that we want to animate, and set a
    # name for it, in this case position animation. The name is used
    # if later we need to access the animation again in another part of the code
    @sun_layer.addAnimation(translation_animation, forKey:'translation_animation')


    # Create another instance of the CABasicAnimation with the property 'transform.rotation.z'
    # this property allows us to change the layer in any of the three dimensions, in this case
    # y axis
    rotation_animation = CABasicAnimation.animationWithKeyPath('transform.rotation.z')

    # Take a note here we are setting 360 degrees, but Core Animation works with radians
    # thats why the conversion PI * 2
    rotation_animation.toValue = NSNumber.numberWithFloat(Math::PI * 2)

    # Set the duration according with the other animation
    rotation_animation.duration = 1

    # Add the animation to the layer
    @sun_layer.addAnimation(rotation_animation, forKey:'rotation_animation')
  end

  def layout_background_layer
    # We need a new type of layer used to create Gradients
    @background_layer = CAGradientLayer.layer
    @background_layer.frame = self.view.bounds

    # Initialize the colors of the gradient, it can have any number of colors
    # in this case we will use only three
    top_background_color = UIColor.colorWithRed(0.131, green:0.387, blue:0.618, alpha:1.0).CGColor
    middle_background_color = UIColor.colorWithRed(0.255, green:0.686, blue:0.984, alpha:1.0).CGColor
    bottom_background_color = UIColor.colorWithRed(0.367, green:0.692, blue:1.0, alpha:1.0).CGColor

    # Set the colors in the layer using an array
    @background_layer.colors = NSArray.arrayWithObjects(top_background_color,
                                                       middle_background_color,
                                                       bottom_background_color,
                                                       nil)

    # Set the colors locations into the array, this means where it will start painting
    # the color, if you look closely we are telling the layer to paint the top color in
    # 0.0 which is the top, the middle in 0.5 and 0.0 for the bottom color
    @background_layer.locations = NSArray.arrayWithObjects(NSNumber.numberWithFloat(0.0),
                                                          NSNumber.numberWithFloat(0.5),
                                                          NSNumber.numberWithFloat(1.0),
                                                          nil)

    # We want this layer to be the background of our app
    self.view.layer.insertSublayer(@background_layer, atIndex:0)
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
    @sun_layer.frame = CGRectMake(0, 0, 180, 180)
    @sun_layer.position = CGPointMake(90, 90)

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