class AppDelegate

  # Lets keep all of our Core Data Objects in here
  ManageObjectClases = [Director, Movie]

  def application(application, didFinishLaunchingWithOptions:launchOptions)
  
    initialize_core_data

    # Create a new instance of our Movies View Controller
    movies_view_controller = MoviesViewController.alloc.init

    # We need to pass the Managed Object Context to the next controller
    # so we can use it later for creating, fetching or deleting objects
    movies_view_controller.managed_object_context = @managed_object_context


    # Add it as a root view controller of a UINavigationController
    navigation_controller = UINavigationController.alloc.initWithRootViewController(movies_view_controller)

    # Create a new UIWindow and add our UINavigationController to it
    @window = UIWindow.alloc.initWithFrame(UIScreen.mainScreen.bounds)
    @window.rootViewController = navigation_controller
    @window.makeKeyAndVisible

    true
  end


  def initialize_core_data

    # First we need to create the NSManagedObjectModel with
    # all the entities and their relationships. You can think of 
    # these object as a reference of the objects for Core Data 
    # to use
    managed_object_model = NSManagedObjectModel.alloc.init
    managed_object_model.entities = ManageObjectClases.collect { |c| c.entity }
    managed_object_model.entities.each { |entity| entity.wireRelationships }

    # The next object needed is the NSPersistentStoreCoordinator
    # which will allow Core Data to persist the information.
    #
    # IMPORT: The NSPersistentStoreCoordinator is not the file or 
    # the database, is just the enabler to write on them
    persistent_store_coordinator = NSPersistentStoreCoordinator.alloc.initWithManagedObjectModel(managed_object_model)
    
    # Now lets get a URL for where do we want Core Data to create
    # the persist file, in this case a SQLite Database File
    persistent_store_file_url = NSURL.fileURLWithPath(File.join(NSHomeDirectory(), 
                                                                'Documents', 
                                                                'RememberTheMovies.sqlite'))


    error_pointer = Pointer.new(:object)

    # Add a new Persistent Store to our Persistent Store Coordinator
    # which these means is that we are telling the Persistent Store 
    # Coordinator where to perform the save of our objects.
    #
    # In these case we are setting that our objects must be stored in
    # a SQLite database in the path we already created previously
    unless persistent_store_coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                                                                   configuration: nil,
                                                                   URL: persistent_store_file_url,
                                                                   options: nil,
                                                                   error: error_pointer)

      # In case that we can't initialize the Persistance Store File
      raise "Can not initialize Core Data Persistance Store Coordinator: #{error_pointer[0].description}"
    end

    # Finally our most important object the Managed Object Context
    # this object is the responsible for creating, destroying and 
    # fetching the objects
    #
    # Of course for it to work we need to assign who is coordinating
    # the object persistence
    @managed_object_context = NSManagedObjectContext.alloc.init
    @managed_object_context.persistentStoreCoordinator = persistent_store_coordinator
  end

end
