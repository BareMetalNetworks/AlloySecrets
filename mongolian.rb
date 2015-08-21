#!/usr/bin/env ruby
require 'pdf-reader'
require 'mongoid'
require 'moped'
require 'optparse'
require 'redis'
require 'rinda/ring'       # for RingServer
require 'rinda/tuplespace' # for TupleSpace
require 'webui/app/models/book/'
#DRb.start_service

# Create a TupleSpace to hold named services, and start running.
#Rinda::RingServer.new(Rinda::TupleSpace.new)

#DRb.thread.join

$:.unshift File.dirname(__FILE__)
options = {}
version = '0.1.0'
help = 'run as a daemon, looks in webui/uploads/pdfs/ for new pdfs and inserts them into mongostore'

op = OptionParser.new
op.banner = "PDF parser and mongoloid insertion daemon"

logger = Logger.new('mongol.log', 'a')
logger.level=Logger::INFO

redi = Redis.new({host: '10.0.1.17', db: '1'})

## Scan local and remote file systems for docs/pdfs insert into mongo
Mongoid.load!("webui/config/mongoid.yml", :production)


# class Book
#   include Mongoid::Document
#   field :title
#   field :author
# 	field :info
# 	field :version
#   field :metadata
# 	field :count
# 	field :timestamp, :type=> Time
#   field :pages, :type => Array
# end

class Mongol
	def self.mongolian_find(hdir)
		pdflocs = []

		hdir.each do |dir|
			findstr =  "find #{dir} -name \"*.pdf\""
			pdflocs = `#{findstr}`.split("\n")
		end
		pdflocs
	end

	def self.mongolian_reader(pdf2read)
		pdf = Hash.new
		pages = Array.new
		reader = PDF::Reader.new(pdf2read)
		pdf[:title] = File.basename pdf2read
		pdf[:version] = reader.pdf_version
		pdf[:info] = reader.info
		pdf[:metadata] = reader.metadata
		pdf[:count] = reader.page_count
    reader.pages.each do |page|
      pages.push(page.text)

		end
		pdf[:pages] = pages
		pdf
	end

	def self.mongolian_penetration(inpdf)
		inserted = Book.create({

															 :title => inpdf[:title],
															 :version => inpdf[:version],
															 :author => inpdf[:author],
															 :info => inpdf[:info],
															 :metadata => inpdf[:metadata],
															 :count => inpdf[:count],
															 :timestamp => Time.now,
															 :pages => inpdf[:pages]
													 })
		[inserted, inpdf]
	end
end

dirs =  %w{webui/uploads/pdf /home/vishnu/}
docLocs = Mongol.mongolian_find(dirs)
docLocs.each do |pdfLoc|
  redi[]
  inserted, original_pdf = Mongol.mongolian_penetration(Mongol.mongolian_reader(pdfLoc))
  logger.info inserted.title
  logger.info inserted.count.to_s
  logger.info "-----------------------------------------"
end



__END__




