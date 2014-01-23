#
# This app read 4 fields from file and store them on mongodb
# Then it gives option to find a record in the mongodb 
# to use with argument use ruby hw4.rb  Your file path     (for ex ruby hw4.rb /Users/zeevstolin/HW/filetoread.csv)
#
require 'mongo_mapper'
require 'mongo'


file_path = ARGV.first  #redding argument
file_name = "/Users/zeevstolin/HW/filetoread.csv" # File name that will be read
db_host = "localhost" # MongoDB db_host
db_port = 27017 # MongoDB db_port
db_name = "hw" # MongoDB Database
db_collection = "hw4" # MongoDB Collection


  puts "Use data from: #{ARGV.first}"


MongoMapper.connection = Mongo::Connection.new(db_host, db_port)
MongoMapper.database = db_name


class Www 
  include MongoMapper::Document
  key :first_name, String 
  key :last_name, String
  key :age, Integer
  key :profession, String
end 

def qwe(file_path) # reding data from /Users/zeevstolin/HW/filetoread.csv , mapping fields and transfering to Mongo... To see data in mongo make db.wwws.find()
	File.open(file_path, 'r') do |file|
	  file.each_line do |line|
	    fields = line.split(',')
		user = Www.create(:first_name => fields[0], :last_name => fields[1], :age => fields[2].to_i , :profession => fields[3])
		user.save
	  end
	end
end

qwe(file_path) 






