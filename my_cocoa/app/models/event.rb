class Event

  attr_accessor :name, :address, :location, :date_as_text, :talks, :longitude, :latitude

  CUPERTINO_LOCATION = {:latitude => 37.334815, :longitude => -122.029781}

  def self.mock_event

    mock_event              = Event.new
    mock_event.name         = "November meeting"
    mock_event.address      = "8 Spruce Street, New York, NY 10038"
    mock_event.date_as_text = "Sat 14th November 2012"
    mock_event.set_coordinates
    mock_event.talks        = [Talk.mock_talk, Talk.mock_talk]
    mock_event
  end

  def set_coordinates
    completion_block = lambda do |placemark, error|
      coordinates = placemark[0].location.coordinate
      @latitude = coordinates.latitude
      @longitude = coordinates.longitude
      self.location = CLLocationCoordinate2DMake(latitude, longitude)
    end
    CLGeocoder.alloc.init.geocodeAddressString(self.address, completionHandler: completion_block)
  end

end