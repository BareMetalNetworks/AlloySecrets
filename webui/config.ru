# This file is used by Rack-based servers to start the application.
require 'thin'
require ::File.expand_path('../config/environment',  __FILE__)
run Rails.application
