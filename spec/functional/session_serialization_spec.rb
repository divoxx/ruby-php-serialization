require "php_serialization"

RSpec.describe "Session serialization" do
  it "should store session correctly" do
    data = PhpSessionSerialization.load("userId|i:123;store|s:3:\"foo\";someArr|a:2:{i:0;b:1;i:1;s:3:\"foo\";}")
    expect(data).to eq(
      "userId"  => 123,
      "store"   => "foo",
      "someArr" => [true, "foo"]
    )
  end

  it "should dump a hash as session" do
    session_hash = {
      "userId"  => 123,
      "store"   => "foo",
      "someArr" => [true, "foo"]
    }

    data = PhpSessionSerialization.load(PhpSessionSerialization.dump(session_hash))
    expect(data).to eq(session_hash)
  end
end
