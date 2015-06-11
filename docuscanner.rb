#!/usr/bin/env ruby

## Scan local and remote file systems for docs/pdfs insert into mongo

#
hostndir = Hash.new
hostndir['localhost'] = '~/'

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




page = Page.create!(:page_num '1', :document_id '1')
doc = Document.create!(:name 'Foo', )
# Create a few records...
show = Show.create!(name: 'Big Bang Theory')

first_episode = show.episodes.create!(name: 'Pilot')
second_episode = show.episodes.create!(name: 'The Big Bran Hypothesis')

episode_names = show.episodes.pluck(:name)

puts "#{show.name} has #{show.episodes.size} episodes named #{episode_names.join(', ')}."
# => Big Bang Theory has 2 episodes named Pilot, The Big Bran Hypothesis.

# Use `binding.pry` here to experiment with this setup.
=end


