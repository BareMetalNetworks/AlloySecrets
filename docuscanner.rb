#!/usr/bin/env ruby

## Scan local and remote file systems for docs/pdfs insert into mongo


hostndir = Hash.new
hostndir['localhost'] = '~/'

def scanfs_docs(hdir)
pdflocs = []

hdir.each_pair do |host, dir|
	if host == 'localhost'

		findstr =  "find #{dir} -name \"*.pdf\""
		                                     p findstr
	pdflocs = `#{findstr}`.split("\n"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                )

	end
doculocs
end
end





