class PhotoLibrary

  attr_accessor :photos
 
def photosArchivePath
	documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, true)
 	#Get one and only document directory from that list
  documentDirectory = documentDirectories.objectAtIndex(0)
	documentDirectory.stringByAppendingPathComponent("photos.archive")	
end

def saveChanges (photo)
	allPhotos = storedPhotos
	allPhotos.addObject(photo)
	@photos = allPhotos
  NSKeyedArchiver.archiveRootObject(@photos , toFile:photosArchivePath)
end

def storedPhotos
		finalArray = NSKeyedUnarchiver.unarchiveObjectWithFile(photosArchivePath)
	if !finalArray
  	finalArray = NSMutableArray.alloc.init
	end
  finalArray
end

end
