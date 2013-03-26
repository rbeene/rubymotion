class PhotoCollectionViewController < UICollectionViewController
	
	def loadView
    views = NSBundle.mainBundle.loadNibNamed "AlbumCollectionView", owner:self, options:nil
    #Assign the first View from the nib file
  	self.collectionView = views[0]
    #Set Data Source
    self.collectionView.dataSource = self
  	styleNavigationBar							
	end

  def viewDidLoad
    super()
    # Load the NIB file
    nib = UINib.nibWithNibName('PhotoCollectionCellView', bundle:nil)
    # Register this NIB which contains the cell
    self.collectionView.registerNib(nib, forCellWithReuseIdentifier:'PhotoCollectionCellView')
    self.collectionView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bgTile"))
  end

  def phothos
    bugs = ["me.png", "misa.png", "juan.png" , "juwe.png"]
  end

	def viewDidDisappear(animated)
    @buttonWithImage.addTarget(self, action: :'showMenu:',forControlEvents:UIControlEventTouchUpInside)
  end

  def showMenu(sender)
    frameView = self.navigationController.view.frame
    frameView.origin.x = 78
    self.navigationController.view.frame = frameView
    @buttonWithImage.addTarget(self, action: :'hideMenu:',forControlEvents:UIControlEventTouchUpInside) 
  end

  def hideMenu(sender)
    frameView = self.navigationController.view.frame
    frameView.origin.x = 0
    self.navigationController.view.frame = frameView
    @buttonWithImage.addTarget(self, action: :'showMenu:',forControlEvents:UIControlEventTouchUpInside) 
  end  

  def styleNavigationBar
    self.navigationController.navigationBar.setBackgroundImage UIImage.imageNamed("navBar.png") ,forBarMetrics: UIToolbarPositionAny
    @buttonWithImage = menuButtonItem
    @buttonWithImage.addTarget(self, action: :'showMenu:',forControlEvents:UIControlEventTouchUpInside)
    barButton = UIBarButtonItem.alloc.initWithCustomView(@buttonWithImage)
    self.navigationItem.leftBarButtonItem = barButton 
  end


  #UICollectionView Datasource

  def collectionView(collectionView, numberOfItemsInSection:section)
    phothos.count
  end

  def numberOfSectionsInCollectionView(collectionView)
    1
  end

  def collectionView(collectionView, cellForItemAtIndexPath:indexPath)
    cell = collectionView.dequeueReusableCellWithReuseIdentifier('PhotoCollectionCellView' ,forIndexPath:indexPath)
    cell.customizeCollectionCell(phothos[indexPath.row])    
    cell
  end

  #UICollectionView Delegate

  def collectionView(collectionView , layout:collectionViewLayout,sizeForItemAtIndexPath:indexPath) 
    CGSizeMake(120, 120)
  end

  def collectionView(collectionView, layout:collectionViewLayout,insetForSectionAtIndex:section)  
     UIEdgeInsetsMake(5, 12, 5, 5) 
  end 
 
end