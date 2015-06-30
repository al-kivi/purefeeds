xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
  xml.title "Aggregate feed from Purefeed"
  xml.description "Purefeed news feeder - built by Vizica"
  xml.link "http://vizi.ca"
	@feeds.each do |feed|
	  xml.item do
	    xml.title feed[:title]
	    xml.link feed[:url]
	    xml.pubDate feed[:published]
	    xml.description feed[:summary]
      end
	end
  end
end