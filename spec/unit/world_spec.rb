require File.dirname(__FILE__) + '/spec_helper'

describe World do
  before :each do
    @app = Object.new 
    
    stub( @app ).width { 800 }
    stub( @app ).height { 600 }
    stub( @app ).fill 
    stub( @app ).rect
    
    @world = World.new( @app )
  end
  
  it "should click all the objects in the world" do
    shape_1 = Shape.new
    shape_2 = Shape.new
    
    event = TuioEvent.new(:click, 1, 1)
    
    mock( shape_1 ).click( event )
    mock( shape_2 ).click( event )
    
    
    things = { :one => shape_1, 
               :two => shape_2 
              }
    
    @world.instance_variable_set( :@things, things )
    
    @world.click( event )
  end
  
  it "should not create a new shape if it already exsists in the world" do
    tuio_object = { :session_id      => 141,
                    :class_id        => 0,
                    :x_pos           => 0.4,
                    :y_pos           => 0.5,
                  }
    shape = Square.new( @app, tuio_object )
              
    mock( Square ).new( @app, tuio_object ).times( 1 ) { shape }
    
    @world.draw( tuio_object )
    @world.draw( tuio_object )
  end

end