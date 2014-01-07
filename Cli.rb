#
# This is a simple client for Ser.rb
# Created by Yuri
#
# This client will open connectio on port 2000 to the server
# It read input from keyboard and send it to the server.
# It read data back from the server
# Client will send 0 to server for disconnect
# To get data client will send 1 to 10
# To get all the history the client will send 999
#

require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 2000
kint = 1 # Keyboard input
rline = "ttttttt" # Data received from Server
soc = TCPSocket.open(hostname, port) # Open session to server

while kint.to_i != 0 
	print "Enter num 0..10: "
	kint = Integer(gets.chomp) rescue -999 # Read number from the keyboard, if not number -999 go to kint
	
	if ((kint > 0 and kint <= 10) or (kint == 999))
		soc.puts kint # Send data to Server
		#rline = soc.recv(1024) #Read data from server
		ll = soc.recv(6)
		rline = soc.recv(ll.to_i - 100000)

		if (rline and (kint.to_i != 0))
			print "Server responded: " + rline.chomp + "\n"
		end
	elsif (kint != 0)
		print "Input  not in range.\n"
	end
end
soc.close               # Close the socket when done
