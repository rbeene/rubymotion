class AddMovieViewController < UITableViewController

  attr_accessor :managed_object_context

  def loadView

    #For security lets set up the fetched_directors array
    @fetched_directors = []

    # Set up the title for the View Controller
    self.title = 'Add Movie'

    # Create a new Table View for showing the Text Fields
    table_view = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                 style:UITableViewStyleGrouped)

    # Set up the view controller as a Data Source
    # of the table view
    table_view.dataSource = self

    # Set up the view controller as a Delegate
    # of the table view
    table_view.delegate = self

    # Add the table view as view of the view controller
    self.view = table_view


    # Add new Bar Button Item to the Navigation Bar for saving
    save_bar_button_item = UIBarButtonItem.alloc.initWithTitle('Save',
                                                               style: UIBarButtonItemStyleDone,
                                                               target: self,
                                                               action: 'save_new_movie')

    # Add the Bar Button Item to the Navigation Bar
    self.navigationItem.rightBarButtonItem = save_bar_button_item

    # Disable the Save button until the user add some text
    # into the text views and select a Director from the list
    self.navigationItem.rightBarButtonItem.enabled = false;
  end


  def save_new_movie

    # Using Core Data create a new instance of the object Movie
    movie = NSEntityDescription.insertNewObjectForEntityForName(Movie.name, 
                                                                inManagedObjectContext: @managed_object_context)

    # Assign the text of the name text field to the movie
    # name
    movie.name = @name_text_field.text

    if @release_year_text_field.text != nil

      # Assign the text of the year text field to the movie
      # year
      movie.release_year = @release_year_text_field.text.intValue
    end

    # Assign the selected director to the movie
    movie.director = @selected_director

    # Create a new pointer for managing the errors
    error_pointer = Pointer.new(:object)

    # Lets persist the new Movie object, saving the managed
    # object context that contains it
    unless @managed_object_context.save(error_pointer)

      # In case we can not save it
      raise "Error saving a new Director: #{error_pointer[0].description}"
    end

    # Pop the Director View Controller
    self.navigationController.popViewControllerAnimated(true)
  end


  def textField(textField, shouldChangeCharactersInRange: range, replacementString: string)

    # If the changing text field is the name one and there is already
    # selected a Director from the list
    if textField == @name_text_field && @selected_director != nil

      # Calculate the final lenght of the text in the UITextField
      text_length = textField.text.length + string.length - range.length


      # If the lenght of the text is greater than 0
      if text_length > 0

        # Enable the save button
        self.navigationItem.rightBarButtonItem.enabled = true;
      else

        # Else disable the save button
        self.navigationItem.rightBarButtonItem.enabled = false;
      end
    end

    true
  end


  def viewWillAppear(animated)

    super

    # Using a NSFetchRequest object we can ask Core Data
    # to fetch specific objects
    fetch_request = NSFetchRequest.alloc.init

    # We need a NSEntityDescription for the Director object
    # so we can tell Core Data which entity we want to 
    # retrieve
    director_entity = NSEntityDescription.entityForName(Director.name, 
                                                        inManagedObjectContext:@managed_object_context)
    fetch_request.setEntity(director_entity)

    # Sort the directors by their "name" attribute
    fetch_sort = NSSortDescriptor.alloc.initWithKey('name',
                                                    ascending: true)
    fetch_request.setSortDescriptors([fetch_sort])


    # Create a new pointer for managing the errors
    error_pointer = Pointer.new(:object)

    # Using the NSManagedObjectContext execute the fetch
    # request
    @fetched_directors = @managed_object_context.executeFetchRequest(fetch_request,
                                                                     error: error_pointer)

    # If the returning array of the fetch request is nil
    # means that a problem has occured
    unless @fetched_directors

      # In case we can not fetch the directors
      raise "Error fetching Directors: #{error_pointer[0].description}"

    end

    # Ask the table view to reload its data
    self.view.reloadData
  end


  # UITableView Data Source

  def numberOfSectionsInTableView(tableView)

    # Lets set two sections one for the Movie General
    # Data and another for a list of Directors
    2
  end


  def tableView(tableView, titleForHeaderInSection: section)

    # Create a new variable to store our header title
    title_for_header = ''


    # If the section is the Directors One
    if section == 1

      # Set the title to the title variable
      title_for_header = 'Choose a Director...'
    end

    # Return the title variable
    title_for_header
  end


  def tableView(tableView, numberOfRowsInSection: section)

    # Lets create a new instance variable for storing 
    # the number of rows in the section
    number_of_rows = 0

    # If the section is General Data
    if section == 0

      # We need two rows
      number_of_rows = 2

    else

      # If the section is Directors we need to add one more
      # to the total of directors fetched because the need of
      # the 'Add Director...' cell
      number_of_rows = @fetched_directors.count + 1
    end

    # Return the number of rows for the section
    number_of_rows
  end


  def tableView(tableView, cellForRowAtIndexPath: indexPath)

    # If the section is General Data
    if indexPath.section == 0

      # Return a General Data Cell
      general_information_cell_for_table_view(tableView, index_path: indexPath)

      # If the section is Directors but is not the 'Add Director...'
      # cell, remember we are adding + 1 to the total fetched directors 
      # count
    elsif indexPath.section == 1 && indexPath.row < @fetched_directors.count

      # Return a Director Cell
      director_cell_for_table_view(tableView, index_path: indexPath)
    else

      # Return a Add Director Cell
      add_director_cell_for_table_view(tableView)
    end
  end


  def director_cell_for_table_view(tableView, index_path: index_path)

    #Create a cell identifier for the Director Cell
    cell_identifier = 'DirectorCell'

    # Dequeue a cell with the identifier
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)


    # If we are not cells to use we need to create one
    if cell == nil

      # Lets create a new UITableViewCell with the identifier
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cell_identifier)
    end

    # Get the fetched director from the array
    director = @fetched_directors[index_path.row]

    # Add the director name to the cell
    cell.textLabel.text = director.name

    cell
  end


  def general_information_cell_for_table_view(tableView, index_path: index_path)

    # Create a cell identifier for the General Information Cell
    cell_identifier = 'GeneralInformationCell'

    # Dequeue a cell with the identifier
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)


    # If we are not cells to use we need to create one
    if cell == nil

      # Lets create a new UITableViewCell with the identifier
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cell_identifier)
      cell.selectionStyle = UITableViewCellSelectionStyleNone

      # Instantiate a new UITextField for editing some values
      cell_text_field = UITextField.alloc.initWithFrame(CGRectMake(100, 11, 200, 30))
      cell_text_field.autocorrectionType = UITextAutocorrectionTypeNo;
      cell_text_field.textColor = UIColor.colorWithRed(0.235, green:0.325, blue:0.506, alpha:1.000)

      # Set the view controller as delegate of the Text Field
      cell_text_field.delegate = self

      # Add the Text Field into the cell view
      cell.addSubview(cell_text_field)

      # If the row is the first one
      if index_path.row == 0

        cell_text_field.placeholder = 'Required'

        # Assign the cell_text_field as name_text_field
        @name_text_field = cell_text_field      
      else

        cell_text_field.placeholder = 'Optional'

        # Assign the cell_text_field as release_year_text_field
        @release_year_text_field = cell_text_field  
      end
    end


    # If the row is the first one
    if index_path.row == 0

      # Set the title to Name
      cell.textLabel.text = 'Name'
    else

      # Else set the title to Year
      cell.textLabel.text = 'Year'
    end

    cell
  end


  def add_director_cell_for_table_view(tableView)

    #Create a cell identifier for the Add Director Cell
    cell_identifier = 'AddDirectorCell'

    # Dequeue a cell with the identifier
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)


    # If we are not cells to use we need to create one
    if cell == nil

      # Lets create a new UITableViewCell with the identifier
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cell_identifier)
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator
    end

    # Add text to the cell
    cell.textLabel.text = 'Add Director...'

    cell
  end


  # UITextField Delegate
  def textFieldShouldReturn(textField)

    # Resign the UITextField as first responder to hide
    # the keyboard
    textField.resignFirstResponder

    true
  end


  # UITableView Delegate

  def tableView(tableView, didSelectRowAtIndexPath: indexPath)

    # If the section is the Directors one and the cell is the
    # 'Add Director...' one
    if indexPath.section == 1 && indexPath.row > @fetched_directors.count - 1 

      # Create a new AddDirectorViewController
      add_director_view_controller = AddDirectorViewController.alloc.init

      # We need to pass the Managed Object Context to the next controller
      # so we can use it later for creating, fetching or deleting objects
      add_director_view_controller.managed_object_context = @managed_object_context 

      # Push it using the Navigation Controller
      self.navigationController.pushViewController(add_director_view_controller, 
                                                   animated:true)

      # If the section is Directors but is not the 'Add Director...'
      # cell, remember we are adding + 1 to the total fetched directors 
      # count
    elsif indexPath.section == 1 && indexPath.row < @fetched_directors.count 

      @selected_director = @fetched_directors[indexPath.row]

      # If the lenght of the text is greater than 0
      if @name_text_field.text != nil && @name_text_field.text.length > 0

        # Enable the save button
        self.navigationItem.rightBarButtonItem.enabled = true;
      end
    end

  end

end
