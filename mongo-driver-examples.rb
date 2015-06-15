
require 'date'

result = client[:restaurants].insert_one({
                                             address: {
    street: '2 Avenue',
    zipcode: 10075,
    building: 1480,
    coord: [-73.9557413, 40.7720266]
},
    borough: 'Manhattan',
    cuisine: 'Italian',
    grades: [
    {
        date: DateTime.strptime('2014-10-01', '%Y-%m-%d'),
    grade: 'A',
    score: 11
},
    {
        date: DateTime.strptime('2014-01-16', '%Y-%m-%d'),
    grade: 'B',
    score: 17
}
],
    name: 'Vella',
    restaurant_id: '41704620'
})

result.n #=> returns 1, because 1 document was inserted.

#########################################################################
# Group documents by field and calculate count.

coll = client[:restaurants]

results = coll.find.aggregate([ { '$group' => { '_id' => '$borough',
                                                'count' => { '$sum' => 1 }
                                }
                                }
                              ])

results.each do |result|
  puts result
end

# Filter and group documents

results = coll.find.aggregate([ { '$match' => { 'borough' => 'Queens',
                                                'cuisine' => 'Brazilian' } },
                                { '$group' => { '_id' => '$address.zipcode',
                                                'count' => { '$sum' => 1 } } }
                              ])

results.each do |result|
  puts result
end


#########################################################################
# Delete all documents matching a condition

client[:restaurants].find('borough' => 'Manhattan').delete_many

# Delete one document matching a condition

client[:restaurants].find('borough' => 'Queens').delete_one

# Delete all documents in a collection

client[:restaurants].find.delete_many

# Drop a collection

client[:restaurants].drop

#########################################################################
result = client[:restaurants].indexes.create(cuisine: Mongo::Index::ASCENDING)

# Create a compound index

result = client[:restaurants].indexes.create(cuisine: 1, zipcode: Mongo::Index::DESCENDING)


#########################################################################
# Query for all documents in a collection

cursor = client[:restaurants].find

cursor.each do |doc|
  puts doc
end

# Query for equality on a top level field

cursor = client[:restaurants].find('borough' => 'Manhattan')

cursor.each do |doc|
  puts doc
end

# Query by a field in an embedded document

cursor = client[:restaurants].find('address.zipcode' => '10075')

cursor.each do |doc|
  puts doc
end

# Query by a field in an array

cursor = client[:restaurants].find('grades.grade' => 'B')

cursor.each do |doc|
  puts doc
end

# Query with the greater-than operator

cursor = client[:restaurants].find('grades.score' => { '$gt' => 30 })

cursor.each do |doc|
  puts doc
end

# Query with the less-than operator

cursor = client[:restaurants].find('grades.score' => { '$lt' => 10 })

cursor.each do |doc|
  puts doc
end

# Query with a logical conjuction (AND) of query conditions

cursor = client[:restaurants].find({ 'cuisine' => 'Italian',
                                     'address.zipcode' => '10075'})

cursor.each do |doc|
  puts doc
end

# Query with a logical disjunction (OR) of query conditions

cursor = client[:restaurants].find('$or' => [{ 'cuisine' => 'Italian' },
                                             { 'address.zipcode' => '10075'}
                                   ]
)

cursor.each do |doc|
  puts doc
end

# Sort query results

cursor = client[:restaurants].find.sort('borough' => Mongo::Index::ASCENDING,
                                        'address.zipcode' => Mongo::Index::DESCENDING)

cursor.each do |doc|
  puts doc
end

##############################
# Update top-level fields in a single document

client[:restaurants].find(name: 'Juni').update_one('$set'=> { 'cuisine' => 'American (New)' },
                                                   '$currentDate' => { 'lastModified'  => true })

# Update an embedded document in a single document

client[:restaurants].find(restaurant_id: '41156888').update_one('$set'=> { 'address.street' => 'East 31st Street' })

# Update multiple documents

client[:restaurants].find('address.zipcode' => '10016').update_many('$set'=> { 'borough' => 'Manhattan' },
                                                                    '$currentDate' => { 'lastModified'  => true })

# Replace the contents of a single document

client[:restaurants].find(restaurant_id: '41704620').replace_one(
    'name' => 'Vella 2',
    'address' => {
        'coord' => [-73.9557413, 40.7720266],
        'building' => '1480',
        'street' => '2 Avenue',
        'zipcode' => '10075'
    }
)