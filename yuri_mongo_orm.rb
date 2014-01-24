#
# This is MongoDB simple ORM for adding and finding pre-defind fields:
# => 1.First Name
# => 2.Last Name
# => 3.Age
# => 4.Profession
#
# This ORM based on Mongo Ruby Driver
# Created by Yuri Groger
#
# Methods:
# => initialize(_host, _port, _db, _user_name, _password)
# => _host,_db, _user_name, _passwords: Strings, _port: Integer
# => Open connectio to MongoDB
#
# => is_auth?()
# => Return true if authentication to MongoDB used, else false
#
# => set_collection (_collection)
# => _collection :String
# => Set current collection inside database
#
# => collection?()
# => Return name of current collection :String
#
# => find(_query)
# => _query :Hash
# => Return array of found record in database by provided query
#
# => insert(_first_name, _last_name, _age, _profession) 
# => _first_name, _last_name, _profession :String, _age :Integer
# => Create new document in collection with provided data
#
#

require "mongo"

class YMongo

	@db_host = "localhost" 	#Default host that running MongoDB
	@db_port = 27017 		#Default port of ongoDB
	@db_database = "default" #Default database name
	@db_user = nil 			#Username to MongoDB
	@db_password = nil 		#Password for MongoDB
	@db_db = nil 			#Database connection
	@db_auth = nil 			# If username,password used to authenticate to MongoDB. 
							#On success will return True, on faild False
	@db_collection = nil 	#Collection to use in MongoDB
	@db_collection_name = nil #Contain collection name to use

	def initialize(_host, _port, _db, _user_name, _password)
		# Will open connectio to MongoDB and authenticate if needed
		# If host,port or db are empty dfault values will be used
		# Id user_name op password are blank, no authentification will be done
		if _host != "" 
			@db_host = _host
		end
		if _port != ""
			@db_port = _port.to_i
		end
		if _db  != ""
			@db_database = _db
		end

		@db_db = Mongo::MongoClient.new(@db_host, @db_port).db(@db_database)
		# Open connection

		if (_user_name != "" and _password != "")
			@db_user = _user_name
			@db_password = _password
			@db_auth = @db_db.authenticate(@db_user, @db_password)
			# Make authentication
		end
	end

	def is_auth?() #Return in case of authentication use True or False. If no auth used, nil.
		if (@db_user and @db_password)
			return @db_auth
		else
			return nil
		end
	end

	def set_collection (_collection) #Set collection name to be used and open it
		if _collection and _collection != ""
			@db_collection_name = _collection
			@db_collection = @db_db.collection(@db_collection_name)
			return true
		else
			return false
		end
	end

	def collection?() #Return current collection name
		return @db_collection_name
	end

	def find(_query) #Find by first_name
		if _query.kind_of?(Hash)
			_ret = @db_collection.find(_query)
			if _ret.count > 0 #Check if anything returned from DB
				_return = []
				_ret.each do |_r|
					_return << _r
				end
				return _return
			else
				return nil
			end
		end
	end

	def insert(_first_name, _last_name, _age, _profession) #Insert document to collection
		if _first_name != "" or _last_name != ""
			_data = {:first_name => _first_name, :last_name => _last_name, :age => _age, :profession => _profession}
			_id = @db_collection.insert(_data)
		end
	end
end
