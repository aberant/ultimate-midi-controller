require File.dirname(__FILE__) + '/../tuio_client'


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

def mock_server
  mock_server = stub("mock_server", :bind => "", :add_method => "")
  OSC::UDPServer.should_receive(:new).and_return(mock_server)
end