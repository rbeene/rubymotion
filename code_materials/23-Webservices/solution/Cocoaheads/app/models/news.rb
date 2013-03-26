class News

  attr_accessor :title, :brief, :note, :date, :image
  
  NEWS_SERVICE_BASE_URL = "http://localhost:4567"
  
  def self.news_mock
    mock_data = news_mock_data    
    news_mock = Array.new
    mock_data.each { |item|      
      news = News.new
      news.title = item["title"] 
      news.brief = item["brief"] 
      news.note = item["text"]
      news.image = item["image"]
      news.date = NSDate.date
      news_mock << news
    }
    news_mock
  end

  
  def self.latest_news( completion_block )  
    
    news_url = NSURL.URLWithString("#{NEWS_SERVICE_BASE_URL}/news.json")
    request = NSMutableURLRequest.requestWithURL(news_url)
    request.setTimeoutInterval(30)
    request.setHTTPMethod("GET")
    queue = NSOperationQueue.alloc.init

    NSURLConnection.sendAsynchronousRequest(request,
      queue: queue,
      completionHandler: lambda do |response, data, error|

        if (data.nil? && error.nil?)
          p "No news were found in the server"
          completion_block.call([], nil)
        elsif( error.nil?)
          
          error_ptr = Pointer.new(:object)
          news = NSJSONSerialization.JSONObjectWithData(data, options:0, error:error_ptr)
          unless news
            raise error_ptr[0]
          end          
          completion_block.call(news_hashes_to_news(news), nil)                  
        elsif( !error.nil? )
          p "Error: #{error}"
          completion_block.call([],"There was an error connecting to the server.")
        end
      end
    )
  end  

  def self.news_hashes_to_news(news_hashes)
    news_array = Array.new
    news_hashes.each { |item|
      news = News.new
      news.title = item["title"] 
      news.brief = item["brief"] 
      news.note = item["text"]
      news.image = item["image"]
      news.date = NSDate.date
      news_array << news
    } 
    news_array
  end


  def self.news_mock_data
    mock_data_path = NSBundle.mainBundle.pathForResource("news_mock", ofType:"plist")
    news_mock_data = NSArray.arrayWithContentsOfFile mock_data_path
  end

end  