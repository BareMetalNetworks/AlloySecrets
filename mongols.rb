#!/usr/bin/env ruby

### Mongolian Search ###
# Author: SJK - July 2015
# AlloySecrets research app. S
# Full text search of mongo database of pdfs
# Index with REDIS + redis-search as a frontend
# This is a command line interface to the alloysecrets system
##############################################################

require 'redis'
require 'redis-search'
require 'redis-namespace'

#options = {redisIP: '10.0.1.13'}

$:.unshift File.dirname(__FILE__)
redi = Redis.new({host: '10.0.1.13', db: '4'})

logger = Logger.new('mongol.log', 'a')
logger.level=Logger::INFO
## Scan local and remote file systems for docs/pdfs insert into mongo


Mongoid.load!("webui/config/mongoid.yml", :production)

class Book
  include Mongoid::Document
  field :title
  field :author
  field :info
  field :version
  field :metadata
  field :count
  field :timestamp, :type=> Time
  field :pages, :type => Array
end