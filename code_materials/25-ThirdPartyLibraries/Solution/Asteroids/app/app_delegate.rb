class AppDelegate

  def application(application, didFinishLaunchingWithOptions:launchOptions)

    # Create a window to present our director
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)

    # Lets create a Cocos 2D view that will be used by the director
    # to present the game scenes
    gl_view = CCGLView.viewWithFrame(@window.bounds,
                                     pixelFormat: KEAGLColorFormatRGBA8,
                                     depthFormat: 0,
                                     preserveBackbuffer: false,
                                     sharegroup: nil,
                                     multiSampling: false,
                                     numberOfSamples: 0)

    # Get the Director shared instance for customization
    @director = CCDirector.sharedDirector
    @director.setProjection(KCCDirectorProjection2D)

    # Specify that we want to run the game in fullscreen
    @director.wantsFullScreenLayout = true

    # Tell the director that we want to present the FPS on
    # the screen
    @director.displayStats = true

    # The prefered speed on our game (FPS)
    # Note: This is only a prefered value its not garantied you will
    # get that value
    @director.animationInterval = 1.0/60

    # Assign the view used for the director to present the
    # game scenes
    @director.view = gl_view


    # Create a navigation controller to store our game director and
    # hide its navigation bar so we can use all the sreen
    @navigation_controller = UINavigationController.alloc.initWithRootViewController(@director)
    @navigation_controller.navigationBarHidden = true

    # Assign the navigation controller to the window
    @window.rootViewController = @navigation_controller
    @window.makeKeyAndVisible


    # Configuration for our game images, this is very helpful
    # when you want to use compressed images or with a different
    # pixel format
    CCTexture2D.defaultAlphaPixelFormat = KCCTexture2DPixelFormat_RGBA8888
    CCTexture2D.PVRImagesHavePremultipliedAlpha(true)

    # Configuration for the names of the images that will be
    # used on the game
    file_utils = CCFileUtils.sharedFileUtils
    file_utils.enableFallbackSuffixes = false

    # The retina display images will be named with "-hd" instead of
    # "@2x"
    file_utils.setiPhoneRetinaDisplaySuffix "-hd"

    # Tell the director to present the SpaceScene, it works similar to a
    # navigation controller: Push to present & Pop to dismiss
    #
    # If you look closelly to the initialization of the scene we are using
    # the node method, instead of new or alloc init this is because Cocos 2D
    # do some memory allocation performance upgrades 
    @director.pushScene(SpaceScene.node)

    true
  end

end
