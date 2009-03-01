class MetaWidget
  attr_reader :widgets
  attr_reader :title
  
  
  def initialize( title = "Default")
    @title = title
    @widgets = []
  end
  
  def widgets
    @widgets
  end
  
  def add_widget( widget )
    @widgets << widget
  end
end