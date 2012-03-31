require 'sinatra/base'
require 'mustache/sinatra'

class App < Sinatra::Base
  register Mustache::Sinatra
  require './views/layout'

  set :mustache, {
    views:     './views',
    templates: './templates'
  }

  get '/' do
    @title = "Gusty: An experiment"
    mustache :index
  end

end
