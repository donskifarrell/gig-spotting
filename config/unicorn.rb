if defined? ENV["PORT"]
	port = ENV["PORT"].to_i
else
	port = 3000
end

listen port, :tcp_nopush => false
worker_processes 4 # amount of unicorn workers to spin up
timeout 30         # restarts workers that hang for 30 seconds
