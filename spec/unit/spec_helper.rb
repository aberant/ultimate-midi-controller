require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')


def be_less_than( expected )
  simple_matcher do |given, matcher|
    matcher.description = "is less than #{expected.inspect}"
    matcher.failure_message = "expected #{given.inspect} to be less then #{expected.inspect}" 
    matcher.negative_failure_message = "expected #{given.inspect} to be more than #{expected.inspect}"     
    given <= expected
  end 
end

def be_more_than( expected )
  simple_matcher do |given, matcher|
    matcher.description = "is more than #{expected.inspect}"
    matcher.failure_message = "expected #{given.inspect} to be more than #{expected.inspect}" 
    matcher.negative_failure_message = "expected #{given.inspect} to be less than #{expected.inspect}" 
    given >= expected
  end 
end

describe "basic shape", :shared => true do
    # it 'should have a title' do
    #   @widget.should respond_to( :title )
    # end
    
    it 'should implement draw' do
      @widget.should respond_to( :draw )
    end
    
    it 'should implement update' do
      @widget.should respond_to( :update )
    end
end