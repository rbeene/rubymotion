class KanjiView < UIView

  def initWithFrame(frame)

    if super

      # In order to does not hide the background image on
      # the controllers view, we need to set the background color on
      # this view as transparent
      self.backgroundColor = UIColor.clearColor

      # Instance an Array for storing the user touches
      @touch_points = NSMutableArray.alloc.init

      layout_cups
      load_kanji_traces

    end

    self

  end


  def layout_cups

    first_cup_frame = CGRectMake(55, 29, 50, 50)

    @first_cup_image_view = UIImageView.alloc.initWithFrame(first_cup_frame)

    @first_cup_image_view.image = UIImage.imageNamed('bgRakuOff1.png')

    self.addSubview(@first_cup_image_view)


    second_cup_frame = CGRectMake(135, 29, 50, 50)

    @second_cup_image_view = UIImageView.alloc.initWithFrame(second_cup_frame)

    @second_cup_image_view.image = UIImage.imageNamed('bgRakuOff2.png')

    self.addSubview(@second_cup_image_view)


    thrid_cup_frame = CGRectMake(215, 29, 50, 50)

    @thrid_cup_image_view = UIImageView.alloc.initWithFrame(thrid_cup_frame)

    @thrid_cup_image_view.image = UIImage.imageNamed('bgRakuOff3.png')

    self.addSubview(@thrid_cup_image_view)

  end


  def load_kanji_traces

    # Create an array to store our Kanji Paths
    @kanji_traces = NSMutableArray.alloc.init


    trace_one = KanjiTrace.new
    trace_one.starting_point = CGPointMake(40, 300)
    trace_one.end_point = CGPointMake(273, 282)

    @kanji_traces.addObject(trace_one)


    trace_two = KanjiTrace.new
    trace_two.starting_point = CGPointMake(155, 285)
    trace_two.end_point = CGPointMake(289, 366)

    @kanji_traces.addObject(trace_two)


    # Continuing the experiment create only a Kanji Trace
    # for the trace number three
    trace_three = KanjiTrace.new
    trace_three.starting_point = CGPointMake(150, 260)
    trace_three.end_point = CGPointMake(152, 367)

    # Add the point to the Kanji Paths array
    @kanji_traces.addObject(trace_three)


    trace_four = KanjiTrace.new
    trace_four.starting_point = CGPointMake(31, 366)
    trace_four.end_point = CGPointMake(145, 294)

    @kanji_traces.addObject(trace_four)


    trace_five = KanjiTrace.new
    trace_five.starting_point = CGPointMake(225, 175)
    trace_five.end_point = CGPointMake(226, 140)

    @kanji_traces.addObject(trace_five)


    trace_six = KanjiTrace.new
    trace_six.starting_point = CGPointMake(219, 202)
    trace_six.end_point = CGPointMake(277, 237)

    @kanji_traces.addObject(trace_six)


    trace_seven = KanjiTrace.new
    trace_seven.starting_point = CGPointMake(69, 191)
    trace_seven.end_point = CGPointMake(33, 160)

    @kanji_traces.addObject(trace_seven)


    trace_eight = KanjiTrace.new
    trace_eight.starting_point = CGPointMake(85, 211)
    trace_eight.end_point = CGPointMake(40, 247)

    @kanji_traces.addObject(trace_eight)


    trace_nine = KanjiTrace.new
    trace_nine.starting_point = CGPointMake(109, 171)
    trace_nine.end_point = CGPointMake(185, 159)

    @kanji_traces.addObject(trace_nine)


    trace_ten = KanjiTrace.new
    trace_ten.starting_point = CGPointMake(190, 171)
    trace_ten.end_point = CGPointMake(186, 241)

    @kanji_traces.addObject(trace_ten)


    trace_eleven = KanjiTrace.new
    trace_eleven.starting_point = CGPointMake(175, 227)
    trace_eleven.end_point = CGPointMake(114, 235)

    @kanji_traces.addObject(trace_eleven)


    trace_twelve = KanjiTrace.new
    trace_twelve.starting_point = CGPointMake(112, 223)
    trace_twelve.end_point = CGPointMake(112, 181)

    @kanji_traces.addObject(trace_twelve)


    trace_thirteen = KanjiTrace.new
    trace_thirteen.starting_point = CGPointMake(114, 161)
    trace_thirteen.end_point = CGPointMake(140, 129)

    @kanji_traces.addObject(trace_thirteen)

  end



  # This method is called when the finger (or fingers) 
  # touch the screen for the first time
  def touchesBegan(touches, withEvent: event)

    # We need to ask the touch for his location according
    # to the current view
    pointInView = touches.anyObject.locationInView(self)


    touch_at_beginning = false

    # Iterate through all the Kanji Paths available
    @kanji_traces.each { | kanji_trace |

      # If the touched point is equal to any Kanji Trace starting
      # point
      if CGRectContainsPoint(kanji_trace.initial_rectangle, pointInView)

        # Assign the trace that the user is currently
        # drawing
        @current_trace = kanji_trace
        touch_at_beginning = true
      end
    }


    # If the touch was at the beginning of any Kanji Trace
    if touch_at_beginning

      # Add the point to our array, but because is a structure (CGPoint)
      # we need to store it on a NSValue
      @touch_points.addObject(NSValue.valueWithCGPoint(pointInView))

      # Ask the view to redraw again
      self.setNeedsDisplay

    else

      # If there is no touch at the beginning means
      # that the user is not drawing a new trace
      @current_trace = nil
    end

  end


  # This method is called when the finger (or fingers) 
  # are moving without leaving the screen
  def touchesMoved(touches, withEvent: event)

    # We need to ask the touch for his location according
    # to the current view
    pointInView = touches.anyObject.locationInView(self)


    # If the user is drawing a trace
    unless @current_trace.nil?

      # Add the touch point into the array, so it can be
      # drawing later
      @touch_points.addObject(NSValue.valueWithCGPoint(pointInView))

      # Evaluate how accurate is the touch in relationship
      # to the trace
      @current_trace.evaluate_point(pointInView)

      # Ask for repainting
      self.setNeedsDisplay
    end

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

    #@touch_points.addObject(NSValue.valueWithCGPoint(pointInView))
    }

  end

  # Method where we need to do the Core Graphics drawing
  def drawRect(rect)

    update_score_board 

    # Get the Core Graphics current context
    context = UIGraphicsGetCurrentContext()

    # Set a color for drawing the touch points
    UIColor.colorWithRed(0.988, green:0.612, blue:0.157, alpha:0.6).set

    # Iterate the touch points
    @touch_points.each { | touch_point |

      # Move the context to the touch point
      CGContextMoveToPoint(context, 
                           touch_point.CGPointValue.x, 
                           touch_point.CGPointValue.y)

    # Create a rect in which want to the ellipse be drawen
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


  def update_score_board

    total_accurate_points = 0

    @kanji_traces.each { | kanji_trace |

        unless kanji_trace.accurate_points.nil?

          total_accurate_points += kanji_trace.accurate_points
        end      
    }

    if total_accurate_points >= 100

      @first_cup_image_view.image = UIImage.imageNamed('bgRakuOn1.png')
    end

    if total_accurate_points >= 200

      @second_cup_image_view.image = UIImage.imageNamed('bgRakuOn2.png')
    end

    if total_accurate_points >= 400

      @thrid_cup_image_view.image = UIImage.imageNamed('bgRakuOn3.png')
    end
  end

end
