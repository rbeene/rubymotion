class NewsTableViewCell < UITableViewCell

  attr_accessor :title, :subtitle, :image_name

  NEWS_CELL_REUSE_ID = "NewsTableViewCell"
  
  def self.cellForNewsItem( news_item, inTableView:tableView )

    cell = tableView.dequeueReusableCellWithIdentifier(NEWS_CELL_REUSE_ID) ||NewsTableViewCell.alloc.initWithStyle(UITableViewCellStyleDefault, reuseIdentifier:NEWS_CELL_REUSE_ID)
    cell.title = news_item.title
    cell.subtitle = news_item.brief    
    cell.image_name = news_item.image
    cell.selectionStyle = UITableViewCellSelectionStyleNone
    cell
  end  


  def layoutSubviews    
    removePreviousViews
    if @background_image.nil?
      @background_image = imageViewWithBackground
      self.addSubview( @background_image )
    end  
    unless @image_name.empty?
      @image_view = imageViewWithNewsImage   
      self.addSubview( @image_view )    
    end  
    @title_label = labelWithTitle
    @subtitle_label = labelWithSubtitle
    
    
    self.addSubview( @title_label )
    self.addSubview( @subtitle_label )
  end  


  def removePreviousViews
    if @image_view
      @image_view.removeFromSuperview 
    end  
    if @title_label
      @title_label.removeFromSuperview
    end  
    if @subtitle_label
      @subtitle_label.removeFromSuperview
    end  
  end    

  def imageViewWithNewsImage
    news_image_view = UIImageView.alloc.initWithImage( UIImage.imageNamed(@image_name) )
    news_image_view.frame = ( [[10,60], [115,115]] )
    news_image_view
  end  

  def labelWithTitle
    title_label = UILabel.alloc.initWithFrame( [[10, 10], [300, 40]] )
    title_label.font = UIFont.fontWithName("Helvetica", size:24)
    title_label.textColor = UIColor.redColor    
    title_label.adjustsFontSizeToFitWidth = true
    title_label.text = @title
    title_label.backgroundColor = UIColor.clearColor
    title_label
  end  

  def labelWithSubtitle
    unless @image_name.empty?
      subtitle_label = UILabel.alloc.initWithFrame( [[140, 60], [170, 115]] )
    else
      subtitle_label = UILabel.alloc.initWithFrame( [[10, 60], [300, 115]] )  
    end  
    subtitle_label.font = UIFont.fontWithName("Helvetica", size:18)
    subtitle_label.text = @subtitle
    subtitle_label.numberOfLines = 4
    subtitle_label.backgroundColor = UIColor.clearColor
    subtitle_label
  end  

  def imageViewWithBackground
    UIImageView.alloc.initWithImage(UIImage.imageNamed("bgNewsCell"))
  end  
end  