require 'sinatra/base'
require 'mustache/sinatra'
require 'omniauth'
require 'omniauth-twitter'

class App < Sinatra::Base
  register Mustache::Sinatra
  require './views/layout'

  # Load env vars from local file - for local dev
  load("./config/local_env.rb") if File.exists?("./config/local_env.rb")

  set :mustache, {
    views:     './views',
    templates: './templates'
  }

  use Rack::Session::Cookie
  use OmniAuth::Builder do
    provider :twitter, ENV["TWITTER_CONSUMER_KEY"], ENV["TWITTER_CONSUMER_SECRET"]
  end

  get '/' do
    @title = "Gusty: An experiment"
    mustache :index
  end

  twitter_auth_callback = lambda do
  	auth = request.env['omniauth.auth']

    # https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
    puts auth[:info][:nickname]
	end
	get  '/auth/:name/callback', &twitter_auth_callback
	post '/auth/:name/callback', &twitter_auth_callback

end
