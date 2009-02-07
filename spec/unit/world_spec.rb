require File.dirname(__FILE__) + '/spec_helper'

describe World do
  before :each do
    app = mock( Object.new )
    @world = World.new( app )
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

end