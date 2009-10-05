require File.dirname(__FILE__) + "/spec_helper"

describe "Serialization" do  
  it "should serialize a integer" do
    PhpSerialization.dump(10).should == "i:10;"
  end
  
  it "should serialize a string" do
    PhpSerialization.dump("Name").should == 's:4:"Name";'
  end
  
  it "should serialize true" do
    PhpSerialization.dump(true).should == 'b:1;'
  end
  
  it "should serialize false" do
    PhpSerialization.dump(false).should == 'b:0;'
  end
  
  it "should serialize nil" do
    PhpSerialization.dump(nil).should ==  'N;'
  end
  
  it "should unzerialize an array" do
    PhpSerialization.dump([true, "foo"]).should == 'a:2:{i:0;b:1;i:1;s:3:"foo";};'
  end
  
  it "should serialize a hash" do
    PhpSerialization.dump("name" => "Rodrigo", "age" => 23).should == 'a:2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;};'
  end
  
  it "should serialize object with class existant" do
    class Person
      attr_accessor :name, :age
    end
    
    person = Person.new
    person.name = "Rodrigo"
    person.age  = 23
    
    PhpSerialization.dump(person).should == 'O:6:"Person":2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;};'
    
    Object.send(:remove_const, :Person)
  end
end