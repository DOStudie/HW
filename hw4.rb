#
# This app read 4 fields from file and store them on mongodb
# Then it gives option to find a record in the mongodb 
#
#
require 'mongo_mapper'
require 'mongo'
#require 'bson'


file_name = "./filetoread.txt" # File name that will be read
db_host = "localhost" # MongoDB db_host
db_port = 27017 # MongoDB db_port
db_name = "hw" # MongoDB Database
db_collection = "hw4" # MongoDB Collection

MongoMapper.connection = Mongo::Connection.new(db_host, db_port)
MongoMapper.database = db_name

def qwe (ttt)
	puts ttt
	{:rrr => "yuri", :tttt => "yosi"}
end

class Www 
  include MongoMapper::Document
  key :first_name, String 
  key :last_name, String
  key :age, Integer
  key :profession, String
end #User class

user = Www.create(:first_name => "yuri1", :last_name => "ddddddd1", :age => 20 , :profession => "none")
user.save

rrr = Www.where(:first_name => "yuri").first
puts rrr[:last_name]

e = qwe("fffffffffffff")
puts "return: #{e}"



