#!/usr/bin/env ruby
require 'pdf-reader'
require 'mongoid'
require 'moped'

## Scan local and remote file systems for docs/pdfs insert into mongo

$:.unshift File.dirname(__FILE__)
Mongoid.load!("webui/config/mongoid.yml", :production)
# Mongoid.configure do |config|
#
#   name = 'alloysecrets_dev_db'
#   host = '10.0.1.32'
#   port = 27017
#   config.database = Mongoid::Connection.new.db(alloysecrets)
# end
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



## Only worrya bout local host for now
def scanfs_docs(hdir)
	pdflocs = []

	hdir.each do |dir|
		findstr =  "find #{dir} -name \"*.pdf\""
		pdflocs = `#{findstr}`.split("\n")
	end
	pdflocs
end

def pdf_reader(pdf2read)
	pdf = Hash.new
	pages = Array.new
	reader = PDF::Reader.new(pdf2read)
  pdf[:title] = File.basename pdf2read
	pdf[:version] = reader.pdf_version
	pdf[:info] = reader.info
	pdf[:metadata] = reader.metadata
	pdf[:count] = reader.page_count
  #pdf[:pages] = reader.map(&:text)
	reader.pages.each do |page|
		pages.push(page.text)
		#puts page.fonts
		#puts page.text
		#puts page.raw_contentdevelopment:
	end
	pdf[:pages] = pages
	pdf
end

def mongolian_horde(inpdf)
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

docLocs = scanfs_docs(['/home/vishnu/Downloads/'])
docLocs.each do |pdfLoc|
  inserted, original_pdf = mongolian_horde(pdf_reader(pdfLoc))
  p  inserted.title
  p inserted.count
  p '-------------------------------------------------'
end


__END__
doclocs=scanfs_docs (hostndir)
p doclocs
doclocs.each do |docloc|
pdfread=pdfreader(docloc)
end



