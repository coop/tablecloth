$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'tablecloth'

def world
  OpenStruct.new(currency: "AUD")
end
