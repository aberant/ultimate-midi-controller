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
    shape = NextPrevWidget.new( @app, tuio_object )
              
    mock( NextPrevWidget ).new( @app, tuio_object ).times( 1 ) { shape }
    @world.send( :draw,  tuio_object )
    @world.send( :draw,  tuio_object )
    
  end
  
  it "should have a config to list what ids become what objects" do
    @world.config[0].should == NextPrevWidget
    @world.config[6].should == SliderWidget
  end
  
  it "should notice the class_id and create the appropriate widget" do
    tuio_next_prev_object = 
      { :session_id      => 141,
        :class_id        => 0,
        :x_pos           => 0.4,
        :y_pos           => 0.5,
      }
      
    tuio_slider_object = 
      { :session_id      => 150,
        :class_id        => 6,
        :x_pos           => 0.5,
        :y_pos           => 0.6,
      }
        
    world = 
      { 141 => tuio_next_prev_object,
        150 => tuio_slider_object
      }
      
    next_prev = NextPrevWidget.new( @app, tuio_next_prev_object )
    
    slider = SliderWidget.new( @app, tuio_slider_object )
    
    mock( NextPrevWidget ).new( @app, tuio_next_prev_object ).times( 1 ) { next_prev }
    mock( SliderWidget ).new( @app, tuio_slider_object ).times( 1 ) { slider }
    
    @world.draw_all( world )
    
  end
  
  it "should update an objects location if the world already knows about it" do
    tuio_next_prev_object = 
      { :session_id      => 141,
        :class_id        => 0,
        :x_pos           => 0.4,
        :y_pos           => 0.5,
      }
    world = { 141 => tuio_next_prev_object }  
    
    next_prev = NextPrevWidget.new( @app, tuio_next_prev_object )
    
    stub( NextPrevWidget ).new { next_prev }

    mock( next_prev ).update( tuio_next_prev_object ).times( 1 )
    
    @world.draw_all( world )
    @world.draw_all( world )    
    
    
    
  end

end