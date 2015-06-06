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





# Run this script with `$ ruby my_script.rb`
require 'mysql2'
require 'active_record'

# Use `binding.pry` anywhere in this script for easy debugging
#require 'pry'

# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
		adapter: 'mysql2',
		database: 'alloysecrets',
	  host: '10.0.0.32',
    user: 'alloysecets',
	  password: 'crazymilkfish$$'


)

# Define a minimal database schema
ActiveRecord::Schema.define do
	create_table :documents, force: true do |t|
		t.integer :id
		t.string :name
		t.string :path

	end

	create_table :pages, force: true do |t|
		t.integer :id
		t.integer :pagenum
		t.integer :document_id
	end

	create_table :words, force: true do |t|
		t.integer :id
		t.string :wordly
		t.integer :page_id

	end

	add_index "wordlists", ["page_id"], :name=> "doc_pages_words"

end

# Define the models
class Document < ActiveRecord::Base
#	has_many :episodes, inverse_of: :show
end

class Page < ActiveRecord::Base
	#belongs_to :show, inverse_of: :episodes, required: true
end
=begin

# Create a few records...
show = Show.create!(name: 'Big Bang Theory')

first_episode = show.episodes.create!(name: 'Pilot')
second_episode = show.episodes.create!(name: 'The Big Bran Hypothesis')

episode_names = show.episodes.pluck(:name)

puts "#{show.name} has #{show.episodes.size} episodes named #{episode_names.join(', ')}."
# => Big Bang Theory has 2 episodes named Pilot, The Big Bran Hypothesis.

# Use `binding.pry` here to experiment with this setup.
=end


