require 'osc'

Host = 'localhost'
Port = 3333

c = OSC::UDPSocket.new
m = OSC::Message.new('/tuio', 'ffff', 42, 1, 1, 1)
c.send m, 0, Host, Port
