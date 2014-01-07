#
# Thisd is simple server app for ruby
# Created Yuri
# Server will listen on port 2000. This is multi client server.
# Server will wait for input from the client and output relevent data.
# Input can be number 0 to 10 and 999.
# On 0 server will send nil to client and close the connectio
# On 1 to 10 relevent data will be sent to client
# On 999 all the history (input:output) between cline-server will be sent to client and 
# history will be cleaned.
#

require 'socket'               # Get sockets from stdlib

rr = ""
server = TCPServer.open(2000)  # Socket to listen on port 2000
loop {                          # Servers run forever
	Thread.start(server.accept) do |client| #Waiting for connection
	iii = 1
	while iii.to_i != 0                         # Servers run unti 0 receive
		iii = client.gets.chomp.to_s
		print "\nClient sent:" + iii
		if iii.to_i == 999 
			client.puts(rr.to_s) #Send history to client
			rr = ""  #Clean history
		end

		if iii.to_i != 0
			ooo = case iii.to_i
			when 1
				"one"
			when 2
				"two"
			when 3
				"three"
			when 4
				"foure"
			when 5
				"five"
			when 6
				"six"
			when 7
				"seven"
			when 8
				"eight"
			when 9
				"nine"
			when 10
				"ten"
			else 
				"No value found!"
			end
			client.puts(ooo.to_s)  # Send data to the clien
			rr = rr + "\n" + iii.to_s + ":" + ooo.to_s + "\n" #Add to history
		else
			client.puts ""
		end

		
	end
	client.close
end
}

