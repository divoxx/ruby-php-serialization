require "php_serialization/serializer"

RSpec.describe PhpSerialization::Serializer do
  it "should serialize a integer" do
    expect(subject.run(10)).to eq("i:10;")
  end

  it "should serialize a string" do
    expect(subject.run("Name")).to eq('s:4:"Name";')
  end

  it "should serialize a symbol string" do
    expect(subject.run(:name)).to eq('s:4:"name";')
  end

  it "should serialize true" do
    expect(subject.run(true)).to eq('b:1;')
  end

  it "should serialize false" do
    expect(subject.run(false)).to eq('b:0;')
  end

  it "should serialize nil" do
    expect(subject.run(nil)).to eq('N;')
  end

  it "should unzerialize an array" do
    expect(subject.run([true, "foo"])).to eq('a:2:{i:0;b:1;i:1;s:3:"foo";}')
  end

  it "should serialize a hash" do
    expect(subject.run("name" => "Rodrigo", "age" => 23)).to eq('a:2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')
  end

  it "should serialize object with class existant" do
    class Person
      attr_accessor :name, :age
    end

    person = Person.new
    person.name = "Rodrigo"
    person.age  = 23

    expect(subject.run(person)).to eq('O:6:"Person":2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')

    Object.send(:remove_const, :Person)
  end
end
