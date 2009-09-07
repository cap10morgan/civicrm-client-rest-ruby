require 'rubygems'
require 'json'

Dir["#{File.dirname(__FILE__)}/civicrm/*.rb"].each { |source_file| require source_file }