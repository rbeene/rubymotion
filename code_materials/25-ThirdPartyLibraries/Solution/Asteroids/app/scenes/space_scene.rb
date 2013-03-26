class SpaceScene < CCScene

 def init

   if super

     # Create a new instance of a Background Layer
     background_layer = BackgroundLayer.node

     # Add it to the scene
     self.addChild(background_layer)


     # Create a new instance of a Game Play Layer
     game_play_layer = GamePlayLayer.node

     # Add it to the scene
     self.addChild(game_play_layer)
   end

   self
 end


end
