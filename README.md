# Purefeeds - An RSS Feed aggregator using Pure CSS and Sinatra

An RSS Feed aggregator built with Sinatra that uses the Pure CSS modules  [Pure.css](http://purecss.io/) to provide responsive screen handling.

![Puresong screenshot](http://vizi.ca/images/poplite.png)

## Audience

This article is intended for people familiar with Sinatra and SQLite who want to use Pure CSS to build responsive applications.

The sample application uses the Feedjira gem to build a usable RSS Feed aggregator. 
The application also uses the Richhtmlticker javascript demonstrate a RSS Feed widget with a rolling screen [richhtmlticker.js] (http://www.javascriptkit.com/script/script2/richhtmlticker.shtml)

## Requirements

* `ruby` >= 1.9 (application was built and tested with Ruby 1.9.3).

## Installation

Download the application to your local desktop. 

Install the required gems (see the Gemfile),

## Usage

The application run in development mode with 'ruby app.rb' command.

The application can also be tested as a rack application with the 'rackup' command.

## What is Purelite?
The Purelite mini-stack includes the following:

* One page application built with Sinatra and ERB
* Sqlite3 with Sequel
* Pure.css javascripts
* Capture of visitor information and emailing with Gmail or Mandrill

## Features
The features shown in the application include:

* Responsive screen using Pure.css capabilities
* Pure.css functions include: top menus, headers and footers
* Show the RSS parsing capabilities of the Feedjira gem. The feed results are stored in the SQLite database
* Present the RSS stored results through a RSS Feed widget
* Forward the RSS stored results through RSS forwarding function.
* A webpage that demonstrates a small SQLite application used to demonstrate menu and button behaviour 
* A webpage that demonstrates a screen to capture contact information from a visitor. This information is send to the website administrator using the Mandrill email application.
* This project is designed to show the capabilities of Pure.css in a Sinatra SQLite application. It is not intended for production use.

## License

This code is dedicated to the public domain to the maximum extent permitted by applicable law, pursuant to CC0 http://creativecommons.org/publicdomain/zero/1.0/

Please reference the copyright restrictions that may apply to the Richhtmlticker javascript.
