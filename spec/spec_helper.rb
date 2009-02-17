require 'rubygems'
require 'spec'
SKETCH_WIDTH = 800
SKETCH_HEIGHT = 600

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

def setup_world
  @app = Object.new
  stub( @app ).width { SKETCH_WIDTH }
  stub( @app ).height { SKETCH_HEIGHT }
  stub( @app ).fill
  stub( @app ).rect

  @world = World.new( @app )
end

def setup_midi
  @driver = Object.new
  stub( @driver ).autodetect_driver
  stub( @driver ).play
  stub( MIDIator::Interface ).new { @driver }
  
  @midi = LiveMidi.new
  stub( @app ).midi { @midi }
end

def abs_to_rel( abs_x, abs_y )
  [abs_x / SKETCH_WIDTH.to_f, abs_y / SKETCH_HEIGHT.to_f]
end

def rel_to_abs( rel_x, rel_y )
  [( rel_x * SKETCH_WIDTH ).to_i, ( rel_y * SKETCH_HEIGHT ).to_i]
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
