class KanjiTrace
  SURROUND_SIZE = 40

  attr_accessor :starting_point
  attr_accessor :end_point

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

end