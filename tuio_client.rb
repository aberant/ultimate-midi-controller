require 'rubygems'
require 'osc'

class TUIOClient
  def initialize(args = { })
    @host = args[:host] || 'localhost'
    @port = args[:port] || 3333
    
    @osc = OSC::UDPServer.new
    @osc.bind @host, @port
    
    @tuio_objects = { }
    @tuio_cursors = { }

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
        
    @osc.add_method '/tuio/2Dobj', 'siiffffffff' do |msg|
      # puts msg.args.inspect
      update_tuio_objects obj_args_to_hash(*msg.args)
    end
    
    @osc.add_method '/tuio/2Dcur', 'sifffff' do |msg|
      # puts msg.args.inspect
      update_tuio_cursors cur_args_to_hash(*msg.args)
    end
    
    @osc.add_method '/tuio/2Dcur', '*' do |msg|
      puts msg.args.inspect
      keep_alive( *msg.args ) if msg.args.first == "alive"
    end
  end
  
  def start
    @osc.serve
  end
  
  def tuio_objects
    @tuio_objects
  end
  
  def tuio_object( id )
    @tuio_objects[id]
  end
  
  def tuio_cursors
    @tuio_cursors
  end  
    
  def tuio_cursor( id )
    @tuio_cursors[id]
  end
  
private
  def cur_args_to_hash( set,
                        session_id,
                        x_pos,
                        y_pos,
                        x_move,
                        y_move,
                        motion_acc)
    raise "whoa not a set!" unless set == "set"
    {
      :session_id  => session_id,
      :x_pos       => x_pos,
      :y_pos       => y_pos,
      :x_move      => x_move,
      :y_move      => y_move,
      :motion_acc  => motion_acc
    }
  end

  def obj_args_to_hash( set, 
                    session_id, 
                    class_id, 
                    x_pos,
                    y_pos,
                    angle,
                    x_move,
                    y_move,
                    angle_move,
                    motion_acc,
                    rotation_acc )
    raise "whoa not a set!" unless set == "set"
    
    { :session_id      => session_id,
      :class_id        => class_id,
      :x_pos           => x_pos,
      :y_pos           => y_pos,
      :angle           => angle,
      :x_move          => x_move,
      :y_move          => y_move,
      :angle_move      => angle_move,
      :motion_acc      => motion_acc,
      :rotation_acc    => rotation_acc
    }
  
  
  end
  
  def update_tuio_objects( args )
    @tuio_objects[args[:session_id]] = args
  end
  
  def update_tuio_cursors( args )
    @tuio_cursors[args[:session_id]] = args
  end
  
  def keep_alive( alive, id )
    
    all_keys = tuio_objects.keys
    dead = all_keys.reject { |key|  id == key }
        
    dead.each do |d|
      tuio_objects.delete( d )
    end
  end
end