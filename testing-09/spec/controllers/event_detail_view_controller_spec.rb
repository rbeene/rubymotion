describe "The Event Details view controller" do

  tests EventDetailViewController

  it "has book button" do
    view('Book Event').should.not.equal nil
  end


  it "book event" do
    button_to_evaluate = view('Book Event')
    tap 'Book Event'
    #wait for 2 seconds
    proper_wait 2
    button_to_evaluate.titleLabel.text.should.equal "Event Booked"
    button_to_evaluate.isEnabled.should.equal false
  end

end