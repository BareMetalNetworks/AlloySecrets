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
	field :reader
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

def pdfreader(pdf2read)
	pdf = Hash.new
	pages = Array.new
	reader = PDF::Reader.new(pdf2read)
  pdf[:title]
	pdf[:version] = reader.pdf_version
	pdf[:reader] = reader.info
	pdf[:metadata] = reader.metadata
	pdf[:count] = reader.page_count

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
														 :reader => inpdf[:reader],
														 :metadata => inpdf[:metadata],
														 :count => inpdf[:count],
														 :timestamp => Time.now,
														 :pages => inpdf[:pages]
												 })

end

books = []
doclocs = scanfs_docs(['/home/vishnu/Downloads/'])
doclocs.each do |pdf|
book = pdfreader(pdf)
  books.push book
  end
p books[0][:count]
p books[1][:pages][1]
p books

__END__
doclocs=scanfs_docs (hostndir)
p doclocs
doclocs.each do |docloc|
pdfread=pdfreader(docloc)
end



