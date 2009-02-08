class LiveMidi
  DELAY = 0.25
  NEXT = 23
  PREV = 21
  PLAY = 24
  
  MIDI_CHANNEL = 0
  
  def initialize
    @midi = MIDIator::Interface.new
    @midi.autodetect_driver
  end
  
  def next
    @midi.play NEXT, DELAY, MIDI_CHANNEL
  end          
               
  def play     
    @midi.play PLAY, DELAY, MIDI_CHANNEL
  end          
               
  def prev     
    @midi.play PREV, DELAY, MIDI_CHANNEL
  end
end