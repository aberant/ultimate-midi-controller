require File.dirname(__FILE__) + '/spec_helper'

describe LiveMidi do
  before :each do
    @driver = Object.new
    stub( @driver ).autodetect_driver
    stub( @driver ).play
    stub( MIDIator::Interface ).new { @driver }
    
    @midi = LiveMidi.new
    
    @class_id = 24
    @cc_number = 0
    @midi_channel = 1
    @value = 64
    
    @midi.config.register( @class_id, [@cc_number, @midi_channel])
  end
  
  it "should call the control change on the driver for slider commands" do
    mock( @driver ).control_change( @cc_number, @midi_channel, @value )
    
    @midi.slider( @class_id, @value )
  end
  
  it "should be able to re-configure the midi configs" do
    new_cc_number = 5
    @midi.config.register( @class_id, [new_cc_number, @midi_channel])
  
    mock( @driver ).control_change( new_cc_number, @midi_channel, @value )
    
    @midi.slider( @class_id, @value )
  end
end