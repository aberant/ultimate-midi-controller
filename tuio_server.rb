require 'rubygems'
require 'osc'

Host = 'localhost'
Port = 3333

s = OSC::UDPServer.new
s.bind Host, Port

# /tuio/2Dobj set ( just the string "set")
#             sessionID(int32) 
#             classID(int32)
#             x postion(float) 
#             y position(float)
#             angle(float) 
#             X movement vector(float)
#             Y movement vector(float)
#             angle movement vector(float)
#             motion acceleration(float) 
#             rotation acceleration(float)

s.add_method '/tuio/2Dobj', 'siiffffffff' do |msg|
  domain, port, host, ip = msg.source
  puts "#{msg.address} -> #{msg.args.inspect}"
end

# /tuio/2Dcur  set
#              sessionId(int) 
#              x
#              y
#              X
#              Y
#              m
#
# s.add_method '/tuio/2Dcur', 'sifffff' do |msg|
#   domain, port, host, ip = msg.source
#   puts "#{msg.address} -> #{msg.args.inspect}"
# end
# 
s.add_method '/tuio/2Dcur', 's*' do |msg|
  domain, port, host, ip = msg.source
  puts "!#{msg.address} -> #{msg.args.inspect}" if msg.args.first == "alive"
  
end
s.serve