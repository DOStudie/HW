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
int = 1
line = "ttttttt"
s = TCPSocket.open(hostname, port)

while int.to_i != 0 
	print "Enter num 0..10: "
	int = gets.chomp.to_i # Read number from the keyboard
	if int >= 0 and int <= 999 
		s.puts int
		if int.to_i != 999
			line = s.gets # Read the responce from server
		else
			line = s.recv(1024) #Read the history from server
		end
		if line
			print "\nServer responded: " + line
		end
	else
		print "\nNumber not in range\n"
	end
end
s.close               # Close the socket when done
