$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'sinatra'
require 'sequel'
require 'sinatra/sequel'  # require is not needed
require 'sqlite3'         # require is not needed
require 'gmail'
#require 'mandrill' # this is an alternative to gmail

require './lib/loader'

# Application helpers.
helpers do
  require 'helpers'
end

database = Sequel.sqlite('development.db')

# Define database migrations. Rending migrations are run once at startup
# ----------------------------------------------------------------------

begin
  migration "create the feeds table" do
    database.create_table :feeds do
      primary_key	:id
      varchar     :title
      varchar     :summary
      varchar			:url
      date				:published
      timestamp   :updated_on
    #    index :title, :unique => true
    end
  end
rescue
  puts "Table already exists"
end

# Basic functions
# -------------------------------------------------------------

get '/' do
  @title = "A Poplite sample website"
  @feeds = Feed.all
  erb :home, :locals => {:active=>["pure-menu-selected","","",""]}
end

get '/widget' do
  @title = "More innovation from Vizica Consulting"
  @feeds = Feed.all
  erb :show_widget, :layout => :layout_widget, :locals => {:active=>["","","pure-menu-selected",""]}
end

get '/contact' do
  @title = "Online information request form"
  @name = ""
  @email = ""
  @comments = ""
  erb :contact, :locals => {:active=>["","","","pure-menu-selected"]}
end

not_found do
  erb :not_found
end

get '/loadnow' do
  @urls = [
  "https://www.realwire.com/rss/?id=349",
  "http://feeds2.feedburner.com/sectors/telecommunications",
  "http://www.lightreading.com/rss_simple.asp"
  ]
  Loader.start (@urls)
  redirect '/'
end

get '/rss' do
  @feeds = Feed.all
  builder :rss
end

# Sample application using SQLite
# ---------------------------------------------------------------------

class Feed < Sequel::Model
  def before_save
  	self[:updated_on] ||= Time.now
  	super
  end
end

get '/feeds' do
  @feeds = Feed.all
  erb :feeds, :locals => {:active=>["","pure-menu-selected","",""]}
end

get '/feeds/new' do
  @feed = Feed.new
  erb :new_feed, :locals => {:active=>["","pure-menu-selected","",""]}
end

get '/feeds/:id' do
  @feed = Feed[(params[:id])]
  erb :show_feed, :locals => {:active=>["","pure-menu-selected","",""]}
end

get '/feeds/:id/edit' do
  @feed = Feed[params[:id]]
  erb :edit_feed, :locals => {:active=>["","pure-menu-selected","",""]}
end

post '/feeds' do
  feed = Feed.create(params[:feed])
  redirect to("/feeds/#{feed.id}")
end

put '/feeds/:id' do
  feed = Feed[params[:id]]
  feed.update(params[:feed])
  redirect to("/feeds/#{feed.id}")
end

get '/feeds/:id/delete' do # notice non-standard method for deletion
  Feed[params[:id]].destroy
  redirect to('/feeds')
end

# Sample application to show mailout capabilities with Gmail
# This Google account has been adjusted for less security 
# -------------------------------------------------------------------------

post '/mailout' do
  @user = ENV["GMAIL_USER"]   # access info stored in environment variables
  @pwd = ENV["GMAIL_PWD"]
  
  gmail = Gmail.connect(@user, @pwd)
  
  email = gmail.compose do	
  end
  
  email['to'] = "admin@xxx.net"  # enter your administrators email here
  email['subject'] = "Request for information from - " + params[:name] + " - " + params[:email]
  email['body'] = params[:comments]
  
  email.deliver! 
  
  gmail.logout
  
  redirect to('/')
end


# Sample application to show mailout capabilities with Mandrill
# -------------------------------------------------------------------------

post '/mailout_option' do

  m = Mandrill::API.new ENV["MANDRILL_API_KEY"] # accesses environment variable
	
  message = {  
   :subject=> "Request for information from - " + params[:name],
   :from_name=> params[:name],  
   :text=>params[:comments],  
   :to=>[  
     { 
       :email=> ENV["ADMIN_EMAIL"]  # accesses environment variable
     }  
   ],  
   :html=>params[:comments],  
   :from_email=> ENV["ADMIN_EMAIL"]  # this needs to match Mandrill setup
  }  
  sending = m.messages.send message

  redirect to('/')
end