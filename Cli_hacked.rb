#
# This is a simple client for Ser.rb
# Created by Yuri
#
# This client will open connectio on port 2000 to the server and pull history each 5s.
#

require 'socket'      # Sockets are in standard library

hostname = '10.0.0.8'
port = 2000
kint = 999 # Keyboard input
soc = TCPSocket.open(hostname, port) # Open session to server

loop {
	soc.write(100000 + kint.to_s.length)
	soc.write(kint) # Send data to Server

	rline = soc.recv(soc.recv(6).to_i - 100000)

	print "Server responded: " + rline.chomp + "\n"
	sleep(5)
}
soc.close               # Close the socket when done
