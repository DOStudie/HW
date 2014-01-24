#
# Connect to MongoDB database and search given collection.
# Created by Yuri Groger
#
#

require "./yuri_mongo_orm.rb"
require 'optparse'

HOST = "localhost"
PORT = 27017
DATABASE = "hw"
USERNAME = ""
PASSWORD = ""
COLLECTION = "wwws"

options = {}

opt_parser = OptionParser.new do |opt|
  opt.banner = "Usage: ruby hw4_find.rb [OPTIONS]"
  opt.separator  ""
  opt.separator  "Options"

  opt.on("-h","--host DB_HOST","specifi the MongoDB host") do |_host|
    HOST = _host
  end

  opt.on("-?","--help","help") do
    puts opt_parser
  end
end

opt_parser.parse!

db = YMongo.new(HOST,PORT,DATABASE,USERNAME,PASSWORD) #Connect to MongoDB
ret = db.set_collection(COLLECTION) #Sel working collection

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
	