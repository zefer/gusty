require 'sinatra/base'
require 'mustache/sinatra'
require 'omniauth'
require 'omniauth-twitter'
require 'ohm'

require './models/user'

class App < Sinatra::Base
  register Mustache::Sinatra
  require './views/layout'

  # Load env vars from local file - for local dev
  load("./config/local_env.rb") if File.exists?("./config/local_env.rb")

  configure :development do
  end

  configure :staging do
  	Ohm.connect(url: ENV["REDIS_URL"])
  end

  configure :production do
  	Ohm.connect(url: ENV["REDIS_URL"])
  end

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
    if current_user
      mustache :home
    else
    	mustache :index
    end
  end

  get "/logout" do
    session['username'] = nil
    redirect '/'
  end

  twitter_auth_callback = lambda do
  	# https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema
  	auth = request.env['omniauth.auth']
  	
    user = User.find(username: auth['info']['nickname']).first || User.create_with_omniauth(auth) if user.nil?

    session['username'] = user.username
    redirect "/"
  end
  get  '/auth/:name/callback', &twitter_auth_callback
  post '/auth/:name/callback', &twitter_auth_callback

  helpers do
    def current_user
      @current_user ||= User.find(username: session['username']).first if session['username']
    end
  end

end
