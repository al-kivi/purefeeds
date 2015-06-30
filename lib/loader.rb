class Loader
	#require 'date'
	require 'feedjira'

	def self.start (urls)
		#-------------------------------------------------------------------
		# Cycle through each url to find feeds
		#-------------------------------------------------------------------

    feedlist = Array.new
    urls.each { |url|
      result = Feedjira::Feed.fetch_and_parse (url)
      feedlist = feedlist + result.entries
    }

		#-------------------------------------------------------------------
		# Store the parsed data to the feeds table
		#-------------------------------------------------------------------
		
		feedlist.each { |item|
		  if Feed.first(:title=>item.title).nil?
        @feed = Feed.new  
  		  @feed[:title] = item.title
  		  @feed[:url] = item.url
  		  @feed[:summary] = item.summary
  		  @feed[:published] = item.published
  		  @feed.save
		  end
		}
		
		p "Total records =" + Feed.count.to_s

  end

end
