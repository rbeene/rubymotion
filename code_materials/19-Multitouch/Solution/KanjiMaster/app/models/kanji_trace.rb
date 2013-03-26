class KanjiTrace 

  SURROUND_SIZE = 30

  attr_accessor :starting_point
  attr_accessor :end_point
  attr_reader :accurate_points 

  def initial_rectangle

    CGRectMake(starting_point.x - SURROUND_SIZE,
               starting_point.y - SURROUND_SIZE,
               SURROUND_SIZE * 2,
               SURROUND_SIZE * 2)
  end


  def final_rectangle

    CGRectMake(end_point.x - SURROUND_SIZE,
               end_point.y - SURROUND_SIZE,
               SURROUND_SIZE * 2,
               SURROUND_SIZE * 2)

  end

  def evaluate_point(point)

    # Lets create properties to store the accurate touches of
    # the user and the missing ones
    @accurate_points ||= 0
    @missing_points ||= 0

    # The next step is creating a surrounding rectangle for the
    # trace, make it more easy for the user to touch
    trace_rect = CGRectMake([starting_point.x, end_point.x].min - SURROUND_SIZE, 
                            [starting_point.y, end_point.y].min - SURROUND_SIZE, 
                            (starting_point.x - end_point.x).abs + SURROUND_SIZE * 2, 
                            (starting_point.y - end_point.y).abs + SURROUND_SIZE * 2)


    # If the point is in the trace
    if CGRectContainsPoint(trace_rect, point)

      # Add one to the accurate points
      @accurate_points += 1
    else

      # Add one to the missing points
      @missing_points += 1
    end

  end

end
