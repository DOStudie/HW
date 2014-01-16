#
# This is a simple REST client for Ser_REST.rb
# This client uses "rest-client" and "json" GEMs
# Created by Yuri
#
# This client will open connectio on port 2103 to the server
# It read input from keyboard and send it to the server.
# Then read data back from the server
# Client will send 0 to server for disconnect
# To get data client will send 1 to 10
# To get all the history the client will send 999
#
# Make sure REST server runs un port 2103
#

require "rest_client"
require "json"


hostname = 'localhost'
port = 2103
kint = 1 # Keyboard input
rline = "ttttttt" # Data received from Server


while kint.to_i != 0 
	print "Enter num 0..10: "
	kint = Integer(gets.chomp) rescue -999 # Read number from the keyboard, if not number -999 go to kint
	
	if ((kint > 0 and kint <= 10) or (kint == 999))

		res = RestClient.get "#{hostname}:#{port.to_s}/test/#{kint.to_s}"

		if ((res.code == 200) and (kint.to_i != 0))
			rline = JSON.parse(res)
			print "Server responded: #{rline["respond"]}\n"
		end
	elsif (kint != 0)
		print "Input  not in range.\n"
	end
end