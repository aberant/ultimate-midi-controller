require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

require 'tuio_event'
require 'world'
require 'live_midi'

NextPrev_ID = 0
Slider_ID = 6


def draw_world
  @world.draw_all @server.tuio_objects
end

def trigger_world_events
  @world.click_all( @server.tuio_cursors )
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

def create_slider_widget( x = 300, y = 100)
  obj_x, obj_y = abs_to_rel( x, y )
  
  send_message( '/tuio/2Dobj', "set", 49, Slider_ID, obj_x, obj_y, 3.14, 0.0, 0.0, 0.0, 0.0, 0.0 )
end

def click_at_the_top_of_the_slider_widget(x = 301, y = 101)
  cur_x, cur_y = abs_to_rel( x, y )
  send_message( '/tuio/2Dcur', "set", 22, cur_x, cur_y, 0.0, 0.0, 0.0 )
end

def click_at_the_bottom_of_the_slider_widget(x = 301, y = SliderWidget::HEIGHT + 99 )
  cur_x, cur_y = abs_to_rel( x, y )
  send_message( '/tuio/2Dcur', "set", 22, cur_x, cur_y, 0.0, 0.0, 0.0 )
end