#!/usr/bin/env ruby
require 'pdf-reader'
## Scan local and remote file systems for docs/pdfs insert into mongo

#
hostndir = Hash.new
hostndir['localhost'] = 'C:/users/mark/documents/'

def scanfs_docs(hdir)
pdflocs = []

hdir.each_pair do |host, dir|
	if host == 'localhost'

		findstr =  "find #{dir} -name \"*.pdf\""

	pdflocs = `#{findstr}`.split("\n")


	end
doculocs
end
end

def pdfreader(pdf2read)
	reader = PDF::Reader.new(pdf2read)

	puts reader.pdf_version
	puts reader.info
	puts reader.metadata
	puts reader.page_count

	reader.pages.each do |page|
		puts page.fonts
		puts page.text
		puts page.raw_content
	end
end

pdfreader('C:\Users\Mark\Documents\sick.pdf')


__END__
doclocs=scanfs_docs (hostndir)
p doclocs
doclocs.each do |docloc|
pdfread=pdfreader(docloc)
end



