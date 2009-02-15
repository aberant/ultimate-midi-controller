require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'widgets/shape'
require 'widgets/next_prev'
require 'widgets/slider'
require 'tuio_event'
require 'world'

require 'live_midi'

NextPrev_ID = 0

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
  
  mock( MIDIator::Interface ).new { @driver }
  
  @midi = LiveMidi.new
  stub( @app ).midi { @midi }
end

def draw_world
  @world.draw_all @server.tuio_objects
end

def trigger_world_events
  @server.tuio_cursors.each do |session_id, tuio_cursor|
    x = ( SKETCH_WIDTH  * tuio_cursor[:x_pos] ).to_i
    y = ( SKETCH_HEIGHT * tuio_cursor[:y_pos] ).to_i
    event = TuioEvent.new(:click, x, y)
    @world.click( event )
  end
end

def create_next_prev_play_widget( x = 300, y = 100)
  # create a next/prev/play object
  obj_x, obj_y = abs_to_rel(x, y)
  send_message( '/tuio/2Dobj', "set", 49, NextPrev_ID, obj_x, obj_y, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
end

def click_next_button_on_next_prev_play_widget
  # click the green button
  cur_x, cur_y = abs_to_rel(345, 101)
  send_message( '/tuio/2Dcur', "set", 22, cur_x, cur_y, 0.0, 0.0, 0.0 )
end

def click_prev_button_on_next_prev_play_widget
  # click the red button
  cur_x, cur_y = abs_to_rel(310, 101)
  send_message( '/tuio/2Dcur', "set", 22, cur_x, cur_y, 0.0, 0.0, 0.0 )
end

def click_play_button_on_next_prev_play_widget
  # click the blue button
  cur_x, cur_y = abs_to_rel(325, 101)
  send_message( '/tuio/2Dcur', "set", 22, cur_x, cur_y, 0.0, 0.0, 0.0 )
end