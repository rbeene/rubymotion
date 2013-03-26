class MenuCell < UITableViewCell

	CELL_ICON_IMAGE = 3
  CELL_TITLE_LABEL = 4
  CELL_SEPARATOR_IMAGE = 5

	def customizeUnSelectedCell(sectionName , iconName)
  	self.backgroundView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bgGreyTexture"))
    titleLabel = self.viewWithTag( CELL_TITLE_LABEL)
    titleLabel.text = sectionName
    titleLabel.textColor = UIColor.lightGrayColor
    separatorImageView = self.viewWithTag(CELL_SEPARATOR_IMAGE)
    separatorImageView.image = UIImage.imageNamed("separatorLine")
    iconImageView = self.viewWithTag(CELL_ICON_IMAGE)
    iconImageView.image = UIImage.imageNamed(iconName)
  end

  def customizeSelectedCell(sectionName , iconName)
    self.backgroundView.backgroundColor = UIColor.colorWithPatternImage(UIImage.imageNamed("bgGreyTextureEnabled"))
    titleLabel = self.viewWithTag( CELL_TITLE_LABEL)
    titleLabel.text = sectionName
    titleLabel.textColor = UIColor.whiteColor
    separatorImageView = self.viewWithTag(CELL_SEPARATOR_IMAGE)
    separatorImageView.image = UIImage.imageNamed("separatorLine") 
    iconImageView = self.viewWithTag(CELL_ICON_IMAGE)
    iconImageView.image = UIImage.imageNamed(iconName)
	end
end