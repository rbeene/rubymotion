class MoviesViewController < UIViewController

  attr_accessor :managed_object_context

  def loadView

    # Set up the title for the View Controller
    self.title = 'Movies'

    # Create a new Table View for showing the Text Fields
    table_view = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                 style:UITableViewStyleGrouped)


    # Create a new Search Bar for the user to add some text
    @search_bar = UISearchBar.alloc.initWithFrame(CGRectMake(0, 70, 320, 44))

    # Set its delegate to movies view controller
    @search_bar.delegate = self

    # Add the Search Bar to the table view header
    table_view.setTableHeaderView(@search_bar)


    # Set up the view controller as a Data Source
    # of the table view
    table_view.dataSource = self

    # Add the table view as view of the view controller
    self.view = table_view


    # Create a new Bar Button Item with the Add System Default
    add_movie_bar_button_item = UIBarButtonItem.alloc.initWithBarButtonSystemItem(UIBarButtonSystemItemAdd,
                                                                                  target: self,
                                                                                  action: 'add_new_movie')

    # Add the Bar Button Item to the Navigation Bar
    self.navigationItem.rightBarButtonItem = add_movie_bar_button_item
  end


  def searchBar(searchBar, textDidChange:searchText)

    # If the SearchBar text contains text execute the search
    # in Core Data, if not clean the search results
    if searchBar.text.length > 0

      # Using a NSFetchRequest object we can ask Core Data
      # to fetch specific objects
      fetch_request = NSFetchRequest.alloc.init

      # We need a NSEntityDescription for the Movie object
      # so we can tell Core Data which entity we want to 
      # retrieve
      director_entity = NSEntityDescription.entityForName(Movie.name, 
                                                          inManagedObjectContext:@managed_object_context)
      fetch_request.setEntity(director_entity)

      # Sort the movies by their "name" attribute
      fetch_sort = NSSortDescriptor.alloc.initWithKey('name',
                                                      ascending: true)
      fetch_request.setSortDescriptors([fetch_sort])


      # Create a predicate for our search query, in this case we want 
      # every Movie that contains in the name or in the Directors name
      # the UISearchBar text
      fetch_predicate = NSPredicate.predicateWithFormat("name contains[cd] %@ OR director.name contains[cd] %@", 
                                                        argumentArray:[searchBar.text, searchBar.text])

      # Add the predicate to our NSFetchRequest
      fetch_request.predicate = fetch_predicate

      # Update the fetch movies array and reload the table view
      update_fetched_movies_with_fetch_request(fetch_request)

    else

      # Reload all the movies
      reload_data
    end
  end


  def viewWillAppear(animated)

    super

    # Fetch the movies from Core Data and update
    # the table view
    reload_data
  end


  def reload_data

    # Using a NSFetchRequest object we can ask Core Data
    # to fetch specific objects
    fetch_request = NSFetchRequest.alloc.init

    # We need a NSEntityDescription for the Movie object
    # so we can tell Core Data which entity we want to 
    # retrieve
    director_entity = NSEntityDescription.entityForName(Movie.name, 
                                                        inManagedObjectContext:@managed_object_context)
    fetch_request.setEntity(director_entity)

    # Sort the movies by their "name" attribute
    fetch_sort = NSSortDescriptor.alloc.initWithKey('name',
                                                    ascending: true)
    fetch_request.setSortDescriptors([fetch_sort])

    # Update the fetch movies array and reload the table view
    update_fetched_movies_with_fetch_request(fetch_request)
  end


  def update_fetched_movies_with_fetch_request(fetch_request)

    # Create a new pointer for managing the errors
    error_pointer = Pointer.new(:object)

    # Using the NSManagedObjectContext execute the fetch
    # request
    @fetched_movies = @managed_object_context.executeFetchRequest(fetch_request,
                                                                  error: error_pointer)

    # If the returning array of the fetch request is nil
    # means that a problem has occured
    unless @fetched_movies

      # In case we can not fetch the directors
      raise "Error fetching Movies: #{error_pointer[0].description}"

    end

    # Ask the table view to reload its data
    self.view.reloadData
  end


  # UITableView Data Source

  def tableView(tableView, numberOfRowsInSection: section)

    # Return the count of the fetched movies 
    @fetched_movies.count
  end


  def tableView(tableView, cellForRowAtIndexPath: indexPath)

    # Create a cell identifier for the Movie Cell
    cell_identifier = 'MovieCell'

    # Dequeue a cell with the identifier
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)


    # If we are not cells to use we need to create one
    if cell == nil

      # Lets create a new UITableViewCell with the identifier
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleValue1, reuseIdentifier:cell_identifier)
      cell.selectionStyle = UITableViewCellSelectionStyleNone
    end


    # Get the fetched movie from the array
    movie = @fetched_movies[indexPath.row]

    # Set the title to the movie name
    cell.textLabel.text = movie.name

    # Set the detail text label to the movie director name
    cell.detailTextLabel.text = movie.director.name

    cell
  end


  def add_new_movie

    # Create a new AddMovieViewController
    add_movie_view_controller = AddMovieViewController.alloc.init

    # We need to pass the Managed Object Context to the next controller
    # so we can use it later for creating, fetching or deleting objects
    add_movie_view_controller.managed_object_context = @managed_object_context


    # Push it using the Navigation Controller
    self.navigationController.pushViewController(add_movie_view_controller, 
                                                 animated:true)
  end


  def tableView(tableView, canEditRowAtIndexPath: indexPath)

    true
  end


  def tableView(tableView, commitEditingStyle: editingStyle, forRowAtIndexPath: indexPath)

    # Get the fetched movie from the array
    movie = @fetched_movies[indexPath.row]

    # Ask the NSManagedObjectContext to delete the object
    @managed_object_context.deleteObject(movie)

    # Create a new pointer for managing the errors
    error_pointer = Pointer.new(:object)

    # Lets persist the deleted Movie object, saving the managed
    # object context that contains it
    unless @managed_object_context.save(error_pointer)

      # In case we can not save it
      raise "Error deleting a Movie: #{error_pointer[0].description}"
    end   


    # Create a new mutable copy of the fetched_movies array
    mutable_fetched_movies = @fetched_movies.mutableCopy
    
    # Remove the movie from the array
    mutable_fetched_movies.delete(movie)

    # Assign the modified array to our fetched_movies property
    @fetched_movies = mutable_fetched_movies

    # Tell the table view to delete the row
    tableView.deleteRowsAtIndexPaths([indexPath], 
                                     withRowAnimation:UITableViewRowAnimationFade)
  end


end
