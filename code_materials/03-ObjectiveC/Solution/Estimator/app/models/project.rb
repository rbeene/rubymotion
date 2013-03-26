class Project

  #Constants representing Keys in the JSON
  COMPLEXITY_DATA_KEY = 'Complexity'
  OUTSOURCED_DATA_KEY = 'Outsourced'
  METHODOLOGY_DATA_KEY = 'Methodology'
  TOTAL_EFFORT_DATA_KEY = 'TotalEffort'
  VARIATION_DATA_KEY = 'Variation'

  attr_accessor :number_of_screens
  attr_accessor :complexity
  attr_accessor :outsourced
  attr_accessor :methodology

  attr_reader :total_effort
  attr_reader :variation
  attr_reader :delivery_year

  

  def estimate 

    @historical_estimates = load_historical_estimates


    obtain_historical_complexity
    obtain_historical_outsourced
    obtain_historical_methodology


    @total_effort =  calculate_total_effort
    @variation = calculate_variation
    @delivery_year = calculate_delivery_year
  end


  private


  def load_historical_estimates

    # Get the path of our JSON File inside the bundle
    historical_data_file  = NSBundle.mainBundle.pathForResource('historical_data', ofType:'json')

    # For us to load the file, we need to pass a pointer. So if something goes wrong we can print
    # the error
    error_pointer = Pointer.new(:object)

    # Lets load the file into a NSData
    historical_data = NSData.alloc.initWithContentsOfFile(historical_data_file,
                                                          options:NSDataReadingUncached,
                                                          error:error_pointer)

    unless historical_data

      if error_pointer[0].code == NSFileReadNoSuchFileError

        $stderr.puts "Error: Missing File Error"

      else

        $stderr.puts "Error: #{error_pointer[0].description}"

      end

      return nil
    end


    # Serialize the NSData into something we can work with, in this case a Hash
    historical_estimates = NSJSONSerialization.JSONObjectWithData(historical_data,
                                                                  options: NSDataReadingUncached,
                                                                  error: error_pointer)

    unless historical_estimates

      $stderr.puts "Error: #{error_pointer[0].description}"

      return nil
    end


    historical_estimates
  end



  def obtain_historical_complexity

    @complexity_total_effort = nil
    @complexity_variation = nil


    historical_complexity = @historical_estimates[COMPLEXITY_DATA_KEY]

    # We use the user selection as a Key
    unless historical_complexity[@complexity].nil?

      selected_historical_complexity = historical_complexity[@complexity]

      @complexity_total_effort = selected_historical_complexity[TOTAL_EFFORT_DATA_KEY]
      @complexity_variation = selected_historical_complexity[VARIATION_DATA_KEY]
    end
  end


  def obtain_historical_outsourced

    @outsourced_total_effort = nil
    @outsourced_variation = nil


    historical_outsourced = @historical_estimates[OUTSOURCED_DATA_KEY]

    # We use the user selection as a Key
    unless historical_outsourced[@outsourced].nil?

      selected_historical_outsourced = historical_outsourced[@outsourced]

      @outsourced_total_effort = selected_historical_outsourced[TOTAL_EFFORT_DATA_KEY]
      @outsourced_variation = selected_historical_outsourced[VARIATION_DATA_KEY]
    end
  end


  def obtain_historical_methodology

    @methodology_total_effort = nil
    @methodology_variation = nil


    historical_methodology = @historical_estimates[METHODOLOGY_DATA_KEY]

    # We use the user selection as a Key
    unless historical_methodology[@methodology].nil?

      selected_historical_methodology = historical_methodology[@methodology]

      @methodology_total_effort = selected_historical_methodology[TOTAL_EFFORT_DATA_KEY]
      @methodology_variation = selected_historical_methodology[VARIATION_DATA_KEY]
    end
  end


  def calculate_total_effort

    # We add all the possible total effort that the user selected
    total_effort_data = @complexity_total_effort + @outsourced_total_effort + @methodology_total_effort

    # Generate a random with the minimum value of a half of the total effort
    total_effort = rand(total_effort_data / 2) + (total_effort_data / 2)

    # Calculate the effort plus the number of screens as percentage
    total_effort * ((@number_of_screens / 100) + 1)
  end


  def calculate_variation

    # We add all the possible variation that the user selected
    variation_data = @complexity_variation + @outsourced_variation + @methodology_variation

    rand(variation_data / 2) + (variation_data / 2)
  end


  def calculate_delivery_year

    # Calculate the total effort plus the posible variation
    total_effort_with_variation = @total_effort * (@variation / 100)

    # Transform the hours into working weeks
    total_effort_days = total_effort_with_variation / 8
    total_effort_weeks = total_effort_days / 5


    # In the following part we add the calculated weeks to the current date
    weekComponent = NSDateComponents.alloc.init
    weekComponent.week = total_effort_weeks

    calendar = NSCalendar.currentCalendar

    delivery_date = calendar.dateByAddingComponents(weekComponent,
                                                    toDate: NSDate.date,
                                                    options: 0)


    # Of the resulting date we only need the year, in the following section is extracted
    yearComponent = calendar.components(NSYearCalendarUnit, fromDate: delivery_date)

    yearComponent.year
  end

end
