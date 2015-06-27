#!/usr/bin/env ruby
require 'pdf-reader'
require 'mongoid'
require 'moped'
require 'optparse'

$:.unshift File.dirname(__FILE__)
options = {}
version = '0.1.0'
help = 'run as a daemon, looks in webui/uploads/pdfs/ for new pdfs and inserts them into mongostore'

op = OptionParser.new
op.banner = "PDF parser and mongoloid insertion daemon"

Logger.new('mongol.log', 'a')
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
		pdf[:pages] = reader.map(&:text)
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

dirs = ['webui/uploads/pdf']
docLocs = Mongol.mongolian_find(dirs)
docLocs.each do |pdfLoc|
  inserted, original_pdf = Mongol.mongolian_penetration(Mongol.mongolian_reader(pdfLoc))
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



