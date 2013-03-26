class  CollectionViewCell < UICollectionViewCell

	CELL_IMAGE_VIEW = 6

	def customizeCollectionCell(imageNamed)
    photoImageView = self.viewWithTag(CELL_IMAGE_VIEW)
    photoImageView.image = UIImage.imageNamed(imageNamed)     
  end

end