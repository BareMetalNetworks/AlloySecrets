# Connect to an in-memory sqlite3 database
ActiveRecord::Base.establish_connection(
		adapter: 'mysql2',
		database: 'alloysecrets',
		host: '10.0.0.32',
		user: 'alloysecets',
		password: 'password'


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
		t.string :term
		t.integer :page_id

	end

	add_index "wordlists", ["page_id"], :name=> "doc_pages_words"

end

# Define the models
class Document < ActiveRecord::Base
	has_many :pages
end

class Page < ActiveRecord::Base
	belongs_to :document # inverse_of: :foo, required: true
	has_many :words
end

class Words < ActiveRecord::Base
	belongs_to :page
end


