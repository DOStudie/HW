#
# Connect to MongoDB database and search in given collection.
# Created by Yuri Groger
#
#

require "./yuri_mongo_orm.rb"
require 'optparse'

# Set default values
host = "localhost"
port = 27017
database = "hw"
username = ""
password = ""
collection = "wwws"

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: ruby hw4_find.rb [OPTIONS]"
  opt.separator  ""
  opt.separator "This program connect to MongoDB and search by:"
  opt.separator "     First Name, Last Name, Age or Proffesion"
  opt.separator ""
  opt.separator  "Options:"

  opt.on("--host DB_HOST","Specifi the MongoDB host. Default: [#{host}]") do |_r|
    host = _r
  end

  opt.on("--port PORT", Integer, "Specifi the MongoDB port. Default: [#{port.to_s}]") do |_r|
    port = _r
  end

  opt.on("--db DATABASE", "Specifi the MongoDB database. Default: [#{database}]") do |_r|
    database = _r
  end

  opt.on("--collection COLLECTION", "Specifi the MongoDB collection. Default: [#{collection}]") do |_r|
    collection = _r
  end

  opt.on("--user USERNAME", "Specifi the MongoDB auth username. Default: [#{username}]") do |_r|
    username = _r
  end

  opt.on("--pass PASSWORD", "Specifi the MongoDB auth username. Default: [#{password}]") do |_r|
    password = _r
  end

  opt.on("-h","--help","help") do
    puts opt_parser
    exit
  end
end

opt_parser.parse!  # Check and if needed read external attributes

db = YMongo.new(host,port,database,username,password) #Connect to MongoDB
ret = db.set_collection(collection) #Sel working collection

if !ret
	puts "Cannot use collection #{COLLECTION}"
	exit
end

#100.times do |i|
#	db.insert("yuri",i.to_s,10,"fffff") 
#end

query = {}
puts "Please fill only one."
print "First name [any]?: "
first_name = gets.chomp

if first_name != ""; query.update(:first_name => first_name); end

print "Last name [any]?: "
last_name = gets.chomp

if last_name != ""; query.update(:last_name => last_name); end

print "Age [any]?: " 
age = gets.chomp

if age != "" and Integer(age); query.update(:age => age.to_i); end

print "Profession [any]?: "
profession = gets.chomp

if profession != ""; query.update(:profession => profession); end

ret = db.find(query)

if ret
	ret.each do |r|
		puts "#{r["first_name"]} #{r["last_name"]}, Age: #{r["age"].to_s}, Profession #{r["profession"]}"
	end
else
	puts "No match !"
end
	