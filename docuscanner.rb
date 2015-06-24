#!/usr/bin/env ruby
require 'pdf-reader'
require 'mongoid'

Mongoid.load!('webui/config/mongoid.yml')

## Scan local and remote file systems for docs/pdfs insert into mongo

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
		#puts page.raw_content
	end
	pdf[:pages] = pages
	pdf
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



