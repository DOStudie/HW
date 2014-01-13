#
# Thisd is simple server app for ruby
# Created Yuri
# Input can be number 0 to 10 and 999.
# On 0 server will send nil to client and close the connectio
# On 1 to 10 relevent data will be sent to client
# On 999 all the history (input:output) between cline-server will be sent to client and 
# history will be cleaned.
#

require "sinatra"
require "json"

respond_to_client = ""

get '/' do
	"Hello to you"
end

get '/test/:request_from_client' do |num_ID| #main process
	content_type :json
	if num_ID.to_i != 0
		respond_to_client = case num_ID.to_i
		when 1
			{:respond => "one"}.to_json
		when 2
			{:respond => "two"}.to_json
		when 3
			{:respond => "three"}.to_json
		when 4
			{:respond => "four"}.to_json
		when 5
			{:respond => "five"}.to_json
		when 6
			{:respond => "six"}.to_json
		when 7
			{:respond => "seven"}.to_json
		when 8
			{:respond => "eight"}.to_json
		when 9
			{:respond => "nine"}.to_json
		when 10
			{:respond => "ten"}.to_json
		else 
			{:respond => "1.618"}.to_json
		end #case end
		#all_history = all_history + num_ID.to_s + ':' + respond_to_client["respond"] + ','
	end #if end
end