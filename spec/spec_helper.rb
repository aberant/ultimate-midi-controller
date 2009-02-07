require 'rubygems'
require 'spec'

VENDOR_ROOT = File.join(File.dirname(__FILE__), "..", "vendor")
LIB_ROOT = File.join(File.dirname(__FILE__), "..", "library")
LIBRARIES = File.join(LIB_ROOT, "*", "*.rb")

Dir[LIBRARIES].each do |lib|
  require lib
end

require File.join(VENDOR_ROOT, "rr", "lib", "rr") 

Spec::Runner.configure do |config|
    config.mock_with RR::Adapters::Rspec
end

# monkey patch to get at osc core to send messages
class TUIOClient
  def osc
    @osc
  end
end

# helper method for integration tests
def send_message( pattern, *msg )
  osc_msg = OSC::Message.new( pattern, nil, *msg)
  
  @server.osc.send( :sendmesg, osc_msg )
end

def setup_server
  mock( socket = Object.new )

  # stub out networking
  stub(socket).bind("", 3333)
  stub(UDPSocket).new { socket }

  @server = TUIOClient.new
end

def cursor_0_hash
  { :session_id      => 141,
    :class_id        => 0,
    :x_pos           => 0.4,
    :y_pos           => 0.5,
    :x_move          => 0.0,
    :y_move          => 0.0,
    :motion_acc      => 0.0,
  }
end

def cursor_0_array
  ["set", 141, 0, 0.4, 0.5, 0.0, 0.0, 0.0]
end

def cursor_1_hash
  { :session_id      => 142,
    :class_id        => 0,
    :x_pos           => 0.5,
    :y_pos           => 0.6,
    :x_move          => 0.0,
    :y_move          => 0.0,
    :motion_acc      => 0.0,
  }
end

def cursor_1_array
  ["set", 142, 0, 0.5, 0.6, 0.0, 0.0, 0.0]
end

def object_0_hash
  { :session_id      => 141,
    :class_id        => 0,
    :x_pos           => 0.4,
    :y_pos           => 0.5,
    :angle           => 3.15,
    :x_move          => 0.0,
    :y_move          => 0.0,
    :angle_move      => 0.0,
    :motion_acc      => 0.0,
    :rotation_acc    => 0.0
  }
end

def object_0_array
  ["set", 141, 0, 0.4, 0.5, 3.15, 0.0, 0.0, 0.0, 0.0, 0.0]
end

def object_1_hash
  { :session_id      => 142,
    :class_id        => 1,
    :x_pos           => 0.5,
    :y_pos           => 0.6,
    :angle           => 6.01,
    :x_move          => 0.0,
    :y_move          => 0.0,
    :angle_move      => 0.0,
    :motion_acc      => 0.0,
    :rotation_acc    => 0.0
  }
end

def object_1_array
  ["set", 142, 1, 0.5, 0.6, 6.01, 0.0, 0.0, 0.0, 0.0, 0.0]
end
