require 'pdf-reader'




s = `find ~/ -name "*.pdf"`

b = s.split(/\n/)

reader = PDF::Reader.new(b[1])

book = Book.new ;book.title = b[1] ;pages = Array.new ;reader.pages.each do |page|; pages.push page.text; end ;
book.pages = pages
book.save!