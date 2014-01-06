#
# Thisd is simple server app for ruby
# Created Yuri
#

require 'socket'               # Get sockets from stdlib

rr = ""
server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                          # Servers run forever
	Thread.start(server.accept) do |client|
	iii = 1
	while iii.to_i != 0                         # Servers run forever
		iii = client.gets.chomp.to_s
		print "\nClient sent:" + iii
		if iii.to_i != 0
			ooo = "ffffff"
			client.puts(ooo.to_s)  # Send the time to the client
			rr = rr + "\n" + iii.to_s + ":" + ooo.to_s
		else
			client.puts ""
		end

		if iii.to_i == 999 
			client.puts(rr.to_s)
			rr = ""
		end
	end
	client.close
end
}

