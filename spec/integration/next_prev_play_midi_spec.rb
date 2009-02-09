require File.dirname(__FILE__) + '/spec_helper'

describe "world when drawing" do
  before :each do
    setup_server
    
    setup_world
    
    setup_midi
  end
  
  it 'should generate a midi next command if the green button is clicked' do
    create_next_prev_play_widget
    
    click_next_button_on_next_prev_play_widget
    
    draw_world
    
    dont_allow( @driver ).play( LiveMidi::PREV, 
                                LiveMidi::DELAY , 
                                LiveMidi::MIDI_CHANNEL 
                              )
                              
    dont_allow( @driver ).play( LiveMidi::PLAY, 
                                LiveMidi::DELAY, 
                                LiveMidi::MIDI_CHANNEL 
                              )
    
    mock( @driver ).play( LiveMidi::NEXT, 
                          LiveMidi::DELAY, 
                          LiveMidi::MIDI_CHANNEL 
                        )
    
    trigger_world_events
  end
  
  it 'should generate a midi previous command if the red button is clicked' do
    create_next_prev_play_widget
    
    click_prev_button_on_next_prev_play_widget
    
    draw_world
    
    dont_allow( @driver ).play( LiveMidi::PLAY, 
                                LiveMidi::DELAY , 
                                LiveMidi::MIDI_CHANNEL 
                              )
                              
    dont_allow( @driver ).play( LiveMidi::NEXT, 
                                LiveMidi::DELAY, 
                                LiveMidi::MIDI_CHANNEL 
                              )
    
    mock( @driver ).play( LiveMidi::PREV, 
                          LiveMidi::DELAY, 
                          LiveMidi::MIDI_CHANNEL 
                        )
    
    trigger_world_events
  end
  
  it 'should generate a midi previous command if the red button is clicked' do
    create_next_prev_play_widget
    
    click_play_button_on_next_prev_play_widget
    
    draw_world
    
    dont_allow( @driver ).play( LiveMidi::PREV, 
                                LiveMidi::DELAY , 
                                LiveMidi::MIDI_CHANNEL 
                              )
                              
    dont_allow( @driver ).play( LiveMidi::NEXT, 
                                LiveMidi::DELAY, 
                                LiveMidi::MIDI_CHANNEL 
                              )
    
    mock( @driver ).play( LiveMidi::PLAY, 
                          LiveMidi::DELAY, 
                          LiveMidi::MIDI_CHANNEL 
                        )
    
    trigger_world_events
  end

end