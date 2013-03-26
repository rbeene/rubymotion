class NewsViewController < UITableViewController

  NEWS_CELL_REUSE_ID = "NewsCellId"

  def initWithStyle(style)
    super
    self.title = "News"
    setupTabBarItem
    self
  end

  def setupTabBarItem
    tab_bar_item = UITabBarItem.alloc.initWithTitle("",
      image:nil, tag:1)
    tab_bar_item.setFinishedSelectedImage(UIImage.imageNamed("icnNews"), withFinishedUnselectedImage:UIImage.imageNamed("icnNews"))
    self.tabBarItem = tab_bar_item
  end

  def tableView(tableView, numberOfRowsInSection:section)
    @news.length
  end

  def tableView(tableView,cellForRowAtIndexPath:indexPath)
    cell                      = tableView.dequeueReusableCellWithIdentifier(NEWS_CELL_REUSE_ID) || UITableViewCell.alloc.initWithStyle(UITableViewCellStyleSubtitle, reuseIdentifier: NEWS_CELL_REUSE_ID)
    news_item                 = @news[ indexPath.row ]
    cell.textLabel.text       = news_item.title
    cell.detailTextLabel.text = news_item.brief
    cell
  end

  def viewWillAppear(animated)
    super
    load_latest_news
  end

  def load_latest_news
    @news = News.news_mock
    self.tableView.reloadData
  end

  def tableView(tableView, didSelectRowAtIndexPath:indexPath)
    p "row #{indexPath.row} selected"
  end

  def tableView(tableView, viewForHeaderInSection:section)
    header_view = UIImageView.alloc.initWithImage(UIImage.imageNamed("bgTitleBar"))
    header_view.frame = [[0,0], [320, 44]]
    header_view.setUserInteractionEnabled(true)
    header_view
  end

  def tableView(tableView, heightForHeaderInSection:section)
    64.0
  end
end