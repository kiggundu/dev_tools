echo "listening on port $1"
ruby -rsocket -e "trap('SIGINT') { exit }; Socket.tcp_server_loop($1) { |s,_| puts s.readpartial(1024); puts; s.puts 'HTTP/1.1 200'; s.close }"
