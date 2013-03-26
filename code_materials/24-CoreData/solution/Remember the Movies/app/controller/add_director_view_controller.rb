class AddDirectorViewController < UITableViewController

  attr_accessor :managed_object_context

  def loadView

    # Set up the title for the View Controller
    self.title = 'Add Director'

    # Create a new Table View for showing the Text Fields
    table_view = UITableView.alloc.initWithFrame(UIScreen.mainScreen.bounds,
                                                 style:UITableViewStyleGrouped)

    # Set up the view controller as a Data Source
    # of the table view
    table_view.dataSource = self

    # Add the table view as view of the view controller
    self.view = table_view

    # Add new Bar Button Item to the Navigation Bar for saving
    save_bar_button_item = UIBarButtonItem.alloc.initWithTitle('Save',
                                                               style: UIBarButtonItemStyleDone,
                                                               target: self,
                                                               action: 'save_new_director')

    # Add the Bar Button Item to the Navigation Bar
    self.navigationItem.rightBarButtonItem = save_bar_button_item

    # Disable the Save button until the user add some text
    # into the UITextView
    self.navigationItem.rightBarButtonItem.enabled = false;
  end


  def save_new_director

    # Using Core Data create a new instance of the object Director
    director = NSEntityDescription.insertNewObjectForEntityForName(Director.name, 
                                                                   inManagedObjectContext: @managed_object_context)

    # Assign the text of the UITextField to the director name
    director.name = @name_text_field.text
 

    # Create a new pointer for managing the errors
    error_pointer = Pointer.new(:object)

    # Lets persist the new Director object, saving the managed
    # object context that contains it
    unless @managed_object_context.save(error_pointer)

      # In case we can not save it
      raise "Error saving a new Director: #{error_pointer[0].description}"
    end

    # Pop the Director View Controller
    self.navigationController.popViewControllerAnimated(true)
  end


  def textField(textField, shouldChangeCharactersInRange: range, replacementString: string)

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

    true
  end


  # UITableView Data Source

  def tableView(tableView, numberOfRowsInSection: section)

    # Because the Director only has one attribute, we only
    # need one cell
    1
  end


  def tableView(tableView, cellForRowAtIndexPath: indexPath)

    # Create a cell identifier for the General Information Cell
    cell_identifier = 'GeneralInformationCell'

    # Dequeue a cell with the identifier
    cell = tableView.dequeueReusableCellWithIdentifier(cell_identifier)


    # If we are not cells to use we need to create one
    if cell == nil

      # Lets create a new UITableViewCell with the identifier
      cell = UITableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:cell_identifier)
      cell.selectionStyle = UITableViewCellSelectionStyleNone

      # Instantiate a new UITextField for editing the name of the 
      # new director
      @name_text_field = UITextField.alloc.initWithFrame(CGRectMake(100, 11, 200, 30))
      @name_text_field.autocorrectionType = UITextAutocorrectionTypeNo;
      @name_text_field.placeholder = 'Required'
      @name_text_field.textColor = UIColor.colorWithRed(0.235, green:0.325, blue:0.506, alpha:1.000)

      # Set the view controller as delegate of the Text Field
      @name_text_field.delegate = self

      # Add the Text Field into the cell view
      cell.addSubview(@name_text_field)
    end


    # Set the title to Name
    cell.textLabel.text = 'Name'

    cell
  end


  # UITextField Delegate
  def textFieldShouldReturn(textField)

    # Resign the UITextField as first responder to hide
    # the keyboard
    textField.resignFirstResponder

    true
  end


end
