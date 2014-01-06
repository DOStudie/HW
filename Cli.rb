#
# This is a simple client for Ser.rb
# Created by Yuri
#

require 'socket'      # Sockets are in standard library

hostname = 'localhost'
port = 2000
int = 1
line = "ttttttt"
s = TCPSocket.open(hostname, port)

while line and int.to_i != 0 # Read lines from the socket
	print "Enter num 0..10: "
	int = gets.chomp.to_i
	if int >= 0 and int <= 999 
		s.puts int
		if int.to_i != 999
			line = s.gets
		else
			line = s.recv(1024)
		end
		if line
			print "\nServer responded: " + line
		end
	else
		print "\nNumber not in range\n"
	end
end
s.close               # Close the socket when done
