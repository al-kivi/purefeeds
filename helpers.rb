#require 'rubygems'

def partial(view)
  erb :"_#{view}", :layout => false
end
