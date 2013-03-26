class AsteroidSprite < CCSprite

  attr_accessor :state

  # This is the designated initializer of the CCSprite
  def initWithTexture(texture, rect:rect)
    
    if super
      @state = :spawning

      spawn
    end

    self

  end

  # Method for optimizing the code needed to instantiate
  # a new asteroid
	def self.sprite

    AsteroidSprite.spriteWithFile('bgAsteroid.png')
  end


  # Method that will manage the spawning points, size 
  # and trayectory of the asteroid
  def spawn 

    # Lets create a Random and generate a number between
    # 25 and 75, the maximum and minimum size for the asteroid
    random = Random.new
    sprite_size = random.rand(25..75)

    # Scale the sprite according to our new generated size 
    self.setScaleX(sprite_size / self.contentSize.width)
    self.setScaleY(sprite_size / self.contentSize.height)


    # Generate an initial and final position for the asteroid
    initial_position = position_outside_screen
    final_position = position_outside_screen

    # Assign the initial position
    self.position = initial_position

    # Calculate the difference between the two positions
    position_difference = CGPointMake(final_position.x - initial_position.x,
                                      final_position.y - initial_position.y)


    # Lets use another random that we will use for the movement speed
    action_speed = random.rand(4..7)
    
    # Create a Move By Action for its movement across the screen
    action = CCMoveBy.actionWithDuration(action_speed, 
                                         position:position_difference)

    # Instantiate a Call Function to excecute a method when the movement 
    # action finished
    finish_callback_action = CCCallFuncND.actionWithTarget(self, 
                                                           selector:'movement_action_ended', 
                                                           data:nil)

    # Chain the both actions using a sequence
    movement_action_sequence = CCSequence.actionsWithArray([action, finish_callback_action])
      
    # Run the movement action sequence
    self.runAction(movement_action_sequence)


    # Create a spinning action with the same speed that the movement one
    # also because we want it to spin a couple of times set the angle 
    # to 1000 degrees    
    spinning_action = CCRotateTo.actionWithDuration(action_speed, 
                                                    angle:1000)

    # Run the spinning action
    self.runAction(spinning_action)

  end

  # Action Movement Callback Method
  def movement_action_ended

    @state = :ended
    
  end


  # Method for calculating positions around the screen
  def position_outside_screen

    # Instantiate a new random
    random = Random.new

    # Generate a new random that we will use to determinate
    # in which screen side is the point
    screen_side = random.rand(1..4)

    # We need to get the screen size for positioning the sprite 
    screen_size = CCDirector.sharedDirector.winSize

    x = 0
    y = 0

    # According to the side of the screen generate the coordinates
    # also we need to take in count the size of the sprite, so it 
    # can be completely outside the screen

    # Top Side
    if screen_side == 1

      x = random.rand(1..screen_size.width)
      y = -self.contentSize.height

    # Left Side
    elsif screen_side == 2
      
      x = -self.contentSize.width
      y = random.rand(1..screen_size.height)

    # Right Side     
    elsif screen_side == 3

      x = 320 + self.contentSize.width
      y = random.rand(1..screen_size.height)
      
    # Bottom Side
    else 

      x = random.rand(1..screen_size.width)
      y = 480 + self.contentSize.height

    end

    CGPointMake(x, y)
  end

end
