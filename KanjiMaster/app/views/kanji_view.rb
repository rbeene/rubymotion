class KanjiView < UIView

  def initWithFrame(frame)

    if super
      # In order to does not hide the background image on
      # the controllers view, we need to set the background color on
      # this view as transparent
      self.backgroundColor = UIColor.clearColor

      # We need to set multipleTouchEnabled to true if we want to handle
      # more than one finger touching the screen
      self.multipleTouchEnabled = true

      # Instance an Array for storing the user touches
      @touch_points = NSMutableArray.alloc.init
      load_kanji_traces
    end

    self

  end

  def load_kanji_traces

    # Create an array to store our Kanji Paths
    @kanji_traces = NSMutableArray.alloc.init

    # As a experiment lets add only the starting point of
    # the trace number three
    kanji_starting_trace_three = CGPointMake(150, 260)


    # Add the point to the Kanji Paths array
    @kanji_traces.addObject(NSValue.valueWithCGPoint(kanji_starting_trace_three))
  end

  # Method where we need to do the Core Graphics drawing
  def drawRect(rect)

    # Get the Core Graphics current context
    context = UIGraphicsGetCurrentContext()

    # Set a color for drawing the touch points
    UIColor.colorWithRed(0.988, green:0.612, blue:0.157, alpha:1.0).set

    # Iterate the touch points
    @touch_points.each { | touch_point |

      # Move the context to the touch point
      CGContextMoveToPoint(context,
                           touch_point.CGPointValue.x,
                           touch_point.CGPointValue.y)

      # Create a rect in which want to the ellipse be drawn
      point_rect = CGRectMake(touch_point.CGPointValue.x - 10,
                              touch_point.CGPointValue.y - 10,
                              20,
                              20)

      # Add the ellipse using the rect into the context
      CGContextAddEllipseInRect(context, point_rect)

      # Draw the context into the view
      CGContextFillPath(context)
    }
  end

  # This method is called when the finger (or fingers)
  # touch the screen for the first time
  def touchesBegan(touches, withEvent: event)

    #  Touches is an set of UITouch, each of them
    #  represent a diferent finger on the screen
    touches.allObjects.each_with_index { | touch, index |

      # We need to ask the touch for his location according
      # to the current view
      pointInView = touch.locationInView(self)
      touch_at_beginning = false

      # Iterate through all the Kanji Paths available
      @kanji_traces.each { | kanji_trace |

        # If the touched point is equal to any Kanji Trace starting
        # point
        @current_trace = kanji_trace
        touch_at_beginning = CGPointEqualToPoint(kanji_trace.CGPointValue, pointInView)
      }
          # If the touch was at the beginning of any Kanji Trace
      unless touch_at_beginning

        # Add the point to our array, but because is a structure (CGPoint)
        # we need to store it on a NSValue
        @touch_points.addObject(NSValue.valueWithCGPoint(pointInView))

        # Ask the view to redraw again
        self.setNeedsDisplay
      else
        @current_trace = nil
      end
    }
  end

  # This method is called when the finger (or fingers)
  # are moving without leaving the screen
  def touchesMoved(touches, withEvent: event)

    #  Touches is an set of UITouch, each of them
    #  represent a diferent finger on the screen
    touches.allObjects.each_with_index { | touch, index |

      # We need to ask the touch for his location according
      # to the current view
      pointInView = touch.locationInView(self)

      @touch_points.addObject(NSValue.valueWithCGPoint(pointInView))
    }
    self.setNeedsDisplay

  end

  # This method is called when the finger (or fingers)
  # leave the screen
  def touchesEnded(touches, withEvent:event)

    #  Touches is an set of UITouch, each of them
    #  represent a diferent finger on the screen
    touches.allObjects.each_with_index { | touch, index |

      # We need to ask the touch for his location according
      # to the current view
      pointInView = touch.locationInView(self)

      NSLog("Touch %@ ended at %@", index + 1, NSStringFromCGPoint(pointInView))
    }

  end

end