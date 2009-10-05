require File.dirname(__FILE__) + "/spec_helper"

describe "Session serialization" do  
  it "should store session correctly" do
    PhpSessionSerialization.load("userId|i:123;store|s:3:\"foo\";someArr|a:2:{i:0;b:1;i:1;s:3:\"foo\";};").should == {
      "userId"  => 123,
      "store"   => "foo",
      "someArr" => [true, "foo"]
    }
  end
  
  it "should dump a hash as session" do
    session_hash = {
      "userId"  => 123,
      "store"   => "foo",
      "someArr" => [true, "foo"]
    }
    
    PhpSessionSerialization.load(PhpSessionSerialization.dump(session_hash)).should == session_hash
  end
end