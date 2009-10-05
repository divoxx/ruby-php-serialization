require File.dirname(__FILE__) + "/spec_helper"

describe "Unserialization" do  
  it "should unserialize a integer" do
    PhpSerialization.load("i:10;").should == 10
  end
  
  it "should unserialize a string" do
    PhpSerialization.load('s:4:"Name";').should == "Name"
  end
  
  it "should unserialize true" do
    PhpSerialization.load('b:1;').should == true
  end
  
  it "should unserialize false" do
    PhpSerialization.load('b:0;').should == false
  end
  
  it "should unserialize nil" do
    PhpSerialization.load('N;').should ==  nil
  end
  
  it "should unzerialize an array" do
    PhpSerialization.load('a:2:{i:0;b:1;i:1;s:3:"foo";}').should == [true, "foo"]
  end
  
  it "should unserialize a hash" do
    PhpSerialization.load('a:2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}').should == {"name" => "Rodrigo", "age" => 23}
  end
  
  it "should unserialize object with class existant" do
    class Person
      attr_accessor :name, :age, :gender
    end
    
    person = PhpSerialization.load('O:6:"Person":2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')
    person.should be_instance_of(Person)
    person.name.should == "Rodrigo"
    person.age.should == 23
    
    Object.send(:remove_const, :Person)
  end
  
  it "should unserialize object without class as a struct" do
    person = PhpSerialization.load('O:6:"Person":2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')
    person.should be_instance_of(Struct::Person)
    person.name.should == "Rodrigo"
    person.age.should == 23
  end
end