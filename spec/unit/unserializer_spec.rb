require "php_serialization/unserializer"

RSpec.describe PhpSerialization::Unserializer do
  it "should unserialize a integer" do
    expect(subject.run("i:10;")).to eq 10
  end

  it "should unserialize a string" do
    expect(subject.run('s:4:"Name";')).to eq "Name"
  end

  it "should unserialize true" do
    expect(subject.run('b:1;')).to eq true
  end

  it "should unserialize false" do
    expect(subject.run('b:0;')).to eq false
  end

  it "should unserialize nil" do
    expect(subject.run('N;')).to eq  nil
  end

  it "should unzerialize an array" do
    expect(subject.run('a:2:{i:0;b:1;i:1;s:3:"foo";}')).to eq [true, "foo"]
  end

  it "should unserialize a hash" do
    expect(subject.run('a:2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')).to eq("name" => "Rodrigo", "age" => 23)
  end

  it "should unserialize object with class existant" do
    class Person
      attr_accessor :name, :age, :gender
    end

    person = subject.run('O:6:"Person":2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')
    expect(person).to be_instance_of(Person)
    expect(person.name).to eq "Rodrigo"
    expect(person.age).to eq 23

    Object.send(:remove_const, :Person)
  end

  it "should unserialize object without class as a struct" do
    person = subject.run('O:6:"Person":2:{s:4:"name";s:7:"Rodrigo";s:3:"age";i:23;}')
    expect(person).to be_instance_of(Struct::Person)
    expect(person.name).to eq "Rodrigo"
    expect(person.age).to eq 23
  end

  it "should unserialize a string with double quotes" do
    expect(subject.run('s:12:"new "Year"";')).to eq "new \"Year\""
  end

  it "should unserialize a string with double quotes in the middle" do
    expect(subject.run("a:3:{i:0;s:4:\"test\";i:1;s:27:\"string with \"quotes\" inside\";s:2:\"in\";s:15:\"middle of array\";}")).to eq(0 => 'test',1 => 'string with "quotes" inside', 'in' => 'middle of array')
  end
end
