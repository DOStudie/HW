require "mongo"
require "benchmark"

time = Benchmark.measure do

db_host = "localhost" # MongoDB db_host
db_port = 27017 # MongoDB db_port
db_name = "hw" # MongoDB Database
db_collection = "wwws" # MongoDB Collection

db = Mongo::MongoClient.new(db_host, db_port).db(db_name)
coll = db.collection(db_collection)

data = {:first_name => "yuri", :last_name => "fffff", :age => 4544, :proffesion => "none"}
coll.insert(data)

ret = coll.find(:first_name => "yuri")
ret.each do |r|
	puts r
end
end
puts time