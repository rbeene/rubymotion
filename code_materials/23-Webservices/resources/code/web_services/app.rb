require 'sinatra'
require 'json'

before %r{.+\.json$} do
	if @news.nil?
		
		@news = JSON.parse( File.read('news.json') )
	end	
    content_type 'application/json'
end

get "/news/:index" do
	if params[:index].to_i >= 0 and params[:index].to_i <= @news.size
		@news[params[:index].to_i].to_json
	else 
		""	
	end

end	

get /news/ do
	@news.to_json
end

