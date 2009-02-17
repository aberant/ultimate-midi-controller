class LiveMidi
  DELAY = 0.1
  NEXT = 23
  PREV = 21
  PLAY = 24
  
  MIDI_CHANNEL = 0
  
  def initialize
    @driver = MIDIator::Interface.new
    @driver.autodetect_driver
  end
  
  def next
    @driver.play NEXT, DELAY, MIDI_CHANNEL
  end          
               
  def play     
    @driver.play PLAY, DELAY, MIDI_CHANNEL
  end          
               
  def prev  
    @driver.play PREV, DELAY, MIDI_CHANNEL
  end
end