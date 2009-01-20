require File.dirname(__FILE__) + '/../spec_helper'

describe TUIOClient do
  before :each do
    mock_server
    
    @tc = TUIOClient.new
  end
  
  describe "interface" do
    
    it "should be able to get a list of tuio objects" do
      @tc.send( :update_tuio_objects, object_0_hash)
      @tc.send( :update_tuio_objects, object_1_hash)
      
      @tc.tuio_objects.length.should == 2
    end
    
    it "should be able to get a specific tuio object by session id" do
      @tc.send( :update_tuio_objects, object_0_hash)
      @tc.send( :update_tuio_objects, object_1_hash)
      
      @tc.tuio_object(object_0_hash[:session_id]).should_not be_nil
    end
    
    it "should be able to get a list of tuio cursors" do
      @tc.send( :update_tuio_cursors, cursor_0_hash)
      @tc.send( :update_tuio_cursors, cursor_1_hash)
      
      @tc.tuio_cursors.length.should == 2
    end
    
    it "should be able to get a specific tuio cursor by session id" do
      @tc.send( :update_tuio_cursors, cursor_0_hash)
      @tc.send( :update_tuio_cursors, cursor_1_hash)
      
      @tc.tuio_cursor(object_0_hash[:session_id]).should_not be_nil
    end
  end
  
  describe 'the innards' do
    it "should be able to convert the tuio args to a hash" do
      @tc.send(:obj_args_to_hash, *object_0_array).should == object_0_hash
    end
    
    it "should represent the data" do
      @tc.send( :update_tuio_objects, object_0_hash)
      @tc.send( :tuio_objects ).should have_key( 141 )
    end
    
    it "should represent multiple objects internally" do
      @tc.send( :update_tuio_objects, object_0_hash)
      @tc.send( :update_tuio_objects, object_1_hash)
      
      @tc.send( :tuio_objects ).should have_key( 141 )
      @tc.send( :tuio_objects ).should have_key( 142 )
    end
    
    it "should be able to delete objects that are no longer alive" do
      @tc.send( :update_tuio_objects, object_0_hash)
      @tc.send( :update_tuio_objects, object_1_hash)
      
      @tc.send( :keep_alive, "alive", 141 )
    
      @tc.send( :tuio_objects ).should have_key( 141 )
      @tc.send( :tuio_objects ).should_not have_key( 142 )
    end
  end
end