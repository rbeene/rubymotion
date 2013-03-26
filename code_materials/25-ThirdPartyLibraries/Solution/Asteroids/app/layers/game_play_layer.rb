class GamePlayLayer < CCLayer

  def init

    if super

      # Create a new sprite instance for drawing our spaceship
      @space_ship_sprite = CCSprite.spriteWithFile('bgSpaceShip.png')

      # We need to get the screen size for positioning the sprite 
      screen_size = CCDirector.sharedDirector.winSize

      # Like the CALayers the position is set in reference to the center
      # of the label, in this case we want the sprite to be in the middle
      # of the screen
      @space_ship_sprite.position = CGPointMake(screen_size.width / 2, screen_size.height / 2)

      # Add the sprite to the Layer
      self.addChild(@space_ship_sprite)

      # Enable handle touches on the layer
      self.isTouchEnabled = true

      #Create an array for storing our asteroid sprites
      @asteroids = NSMutableArray.alloc.init

      # Subscribe to the loop call
      scheduleUpdate
   
    end

    self
  end

  # Loop callback method
  def update(time)

    spawn_asteroids
    check_for_collisions
  end


  def spawn_asteroids

    # Delete the asteroids that are on ended state
    @asteroids.delete_if { | asteroid |

      # If the asteroid is on ended state
      if asteroid.state == :ended

        # Remove from the layer also
        self.removeChild(asteroid, cleanup:true)

        true        
      end
    }

    # Calculate the number of asteroids missing, taking
    # in count that we should have 20 moving around
    missing_asteroids = 15 - @asteroids.count
    
    # Iterate to create the missing asteroids
    for i in 0..missing_asteroids - 1

      # Create an asteroid sprite
      asteroid_sprite = AsteroidSprite.sprite

      # Add it to the layer and to the array
      self.addChild(asteroid_sprite)
      @asteroids.addObject(asteroid_sprite)
    end
  end

  def check_for_collisions

    # Iterate all the asteroids in the scene
    @asteroids.each { | asteroid |

      # If any asteroid frame intersect the space ship frame
      # is a collision
      if CGRectIntersectsRect(asteroid.boundingBox, @space_ship_sprite.boundingBox)
      
        # Create a new sprite instance for our explosion
        explosion_sprite = CCSprite.spriteWithFile('bgBoom.png')
       
        # Set the sprite in the same exact position of the 
        # space ship
        explosion_sprite.position = @space_ship_sprite.position

        # Add the explosion sprite into our layer
        self.addChild(explosion_sprite)

        # Pause the game
        CCDirector.sharedDirector.pause
      end
    }
  end

  # Method for handling the initial touch of the user
  # Very similar to the way iOS manage it
  def ccTouchesBegan(touches, withEvent:event)

    # Get any touch of the user
    touch = touches.anyObject

    # Because we are not using a UIView or anything related
    # we need to use a method to convert the touch position 
    # coordinate space into the layer space
    touch_location = self.convertTouchToNodeSpace(touch)

    # Get the current position of the space ship
    current_location = @space_ship_sprite.position

    # Calculate the difference between the two points
    location_difference = CGPointMake(touch_location.x - current_location.x,
                                      touch_location.y - current_location.y)

    # We need to create a MoveBy action for the animated movement
    action = CCMoveBy.actionWithDuration(0.3, 
                                         position:location_difference)

    # Execute the action in our Space Ship Sprite
    @space_ship_sprite.runAction(action)
  end

end
