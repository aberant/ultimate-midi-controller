class LiveMidi
  DELAY = 0.1
  NEXT = 23
  PREV = 21
  PLAY = 24
  
  MIDI_CHANNEL = 0
  
  def initialize
    @driver = MIDIator::Interface.new
    @driver.autodetect_driver
    
    @config = EnvConfig.create_config do
      :play.is 24
      :prev.is 21
      :next.is 23
      :play_channel.is 0
      
      # begin slider config
      # hmm.. the dsl seems to stretch thin here...
      [0,0].is 6
    end
  end
  
  def config
    @config
  end
  
  def next
    @driver.play  @config.fetch(:next), 
                  DELAY, 
                  @config.fetch(:play_channel)
  end          
               
  def play     
    @driver.play  @config.fetch(:play), 
                  DELAY, 
                  @config.fetch(:play_channel)
  end          
               
  def prev  
    @driver.play  @config.fetch(:prev), 
                  DELAY, 
                  @config.fetch(:play_channel)
  end
  
  def slider( id, value )
    cc_number, channel = @config.fetch( id )
    
    @driver.control_change( cc_number, channel, value )
  end
end