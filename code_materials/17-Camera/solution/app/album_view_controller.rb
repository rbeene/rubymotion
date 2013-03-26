class AlbumViewController < UIViewController

  MENU_TABLE_VIEW_TAG = 1
  

  #Method that returns the sections of menu 
  def menuSections
    sections = ["Frame", "Album","Camera"]
  end

  #Method that returns the icons selected for ech section
  def menuSelectedIcons
    selectedIcons = ["frameEnabled.png", "albumEnabled.png","cameraEnabled.png"]
  end
  #Method that returns the icons unselected for ech section
  def menuUnSelectedIcons
    unSelectedIcons = ["frameDisabled.png", "albumDisabled.png","cameraDisabled.png"]
  end
  #Table View Data Source 
  def numberOfSectionsInTableView(tableView)
    1
  end
 
  def tableView(tableView,numberOfRowsInSection:section)
    menuSections.count
  end

  #Table View Delegate 
  
  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    
    # Check for a reusable cell first, use that if it exists
    cell = tableView.dequeueReusableCellWithIdentifier('MenuCellView')

    #if the cell has selected customize with select style otherwise customize with unselected style
    if @selectedRows[indexPath.row]
      cell.customizeSelectedCell(menuSections[indexPath.row],menuSelectedIcons[indexPath.row])
    else
      cell.customizeUnSelectedCell(menuSections[indexPath.row],menuUnSelectedIcons[indexPath.row])
    end
    cell
  end
  #return heigth for the current cell 
  def tableView tableView,heightForRowAtIndexPath:indexPath
  	85
  end

  def tableView tableView,didSelectRowAtIndexPath:indexPath
  	
    #if we tap in the selected row do nothing
    if @currentSection == indexPath.row
      return
    end

    cell = tableView.cellForRowAtIndexPath indexPath
  	#customize selected cell
    cell.customizeSelectedCell(menuSections[indexPath.row],menuSelectedIcons[indexPath.row])
    #clean all previous cells
    @selectedRows.each_key {|key| 
      @selectedRows[key] = false 
    }
    if indexPath.row == 0
      loadFrameView
    elsif indexPath.row == 1
      loadCollectionView
    elsif indexPath.row == 2
      loadCameraView   
    end
    
    removePreviousLayer

    #set selected cell
    @selectedRows[indexPath.row] = true
    tableView.reloadData
  end

  def removePreviousLayer
    views = self.view.subviews
    previousView = views[1]
    previousView.removeFromSuperview
  end

	def loadView
    super ()
    @selectedRows = Hash.new
    #Load the nib file  
		views = NSBundle.mainBundle.loadNibNamed "AlbumView", owner:self, options:nil
    #Assing the first View from the nib file
  	self.view = views[0]
  	@tableView = self.view.viewWithTag( MENU_TABLE_VIEW_TAG )
  	@tableView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bgGreyTexture"))
  	@tableView.dataSource = @tableView.delegate = self
    loadFrameView	
    @tableView.reloadData								
	end

  def viewDidLoad
    super()
    # Load the NIB file
    nib = UINib.nibWithNibName('MenuCellView', bundle:nil)
    # Register this NIB which contains the cell
    @tableView.registerNib(nib, forCellReuseIdentifier:'MenuCellView')
  end
  
  def loadFrameView
    #avoid to create the same instance of the controllers more than once
    if !@photoFrameViewController && !@photoFrameNavigationViewController
      @photoFrameViewController = PhotoFrameViewController.alloc.init
      @photoFrameNavigationViewController = UINavigationController.alloc.initWithRootViewController(@photoFrameViewController)
    end
    @photoFrameNavigationViewController.view.frame = self.view.bounds
    view.addSubview(@photoFrameNavigationViewController.view)
    #set the current section
    @selectedRows[0] = true
    @currentSection = 0
  end

  def loadCollectionView
    #avoid to create the same instance of the controllers more than once
    if !@photoCollectionViewControllerr && !@photoCollectionNavigationViewController
      @photoCollectionViewController = PhotoCollectionViewController.alloc.init
      @photoCollectionNavigationViewController = UINavigationController.alloc.initWithRootViewController(@photoCollectionViewController)
    end
    @photoCollectionNavigationViewController.view.frame = self.view.bounds
    view.addSubview(@photoCollectionNavigationViewController.view)
    #set the current section
    @selectedRows[1] = true
    @currentSection = 1
  end
  
  def loadCameraView
    #avoid to create the same instance of the controllers more than once
    if !@cameraViewController && !@cameraNavigationViewController
      @cameraViewController = CameraViewController.alloc.init
      @cameraNavigationViewController = UINavigationController.alloc.initWithRootViewController(@cameraViewController)
    end
    @cameraNavigationViewController.view.frame = self.view.bounds
    view.addSubview(@cameraNavigationViewController.view)
    #set the current section
    @selectedRows[2] = true
    @currentSection = 2
  end
  
end