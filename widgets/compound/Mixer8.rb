class Mixer8Widget < MetaWidget
  
  def initialize( app, tuio_obj )
    super( app, tuio_obj )
    
    setup_sub_widgets
  end
  
  
private

  def setup_sub_widgets
    (1..8).each do | count |
      tuio_object = @tuio
      tuio_object[:y_pos] = tuio_object[:y_pos] + ( count * 20 )
      
      add_widget( SliderWidget.new( @app, tuio_object ))
    end
  end
end
