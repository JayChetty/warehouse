require_relative '../alpha_numeric_rack_adapter.rb'

describe AlphaNumericRackAdapter do
  let(:item_finder){ double('finder') }
  let(:adapter){adapter = AlphaNumericRackAdapter.new(['a','b','c'], 10 )}

  it "should convert alpha numeric strings to array indexes" do
    expect( adapter.key_to_index("a1") ).to eq(0)
    expect( adapter.key_to_index("b1") ).to eq(10)
    expect( adapter.key_to_index("c10") ).to eq(29)
  end

  it "should alter number of reversed racks if stated" do
    adapter_with_inversion = AlphaNumericRackAdapter.new( ['a','b','c'], 10, [ 'a','c' ] )
    expect( adapter_with_inversion.key_to_index("a10") ).to eq(0)
    expect( adapter_with_inversion.key_to_index("b1") ).to eq(10)
    expect( adapter_with_inversion.key_to_index("c10") ).to eq(20)
  end

  it "should convert indexes to alpha numeric strings" do
    expect( adapter.index_to_key(0) ).to eq("a1")
    expect( adapter.index_to_key(10) ).to eq("b1")
    expect( adapter.index_to_key(29) ).to eq("c10")
  end

  it "should alter alpha numeric strings of reversed racks if stated" do
    adapter_with_inversion = AlphaNumericRackAdapter.new( ['a','b','c'], 10, [ 'a','c' ] )
    expect( adapter_with_inversion.index_to_key(0) ).to eq("a10")
    expect( adapter_with_inversion.index_to_key(10) ).to eq("b1")
    expect( adapter_with_inversion.index_to_key(20) ).to eq("c10")
  end

  it "raise exeception if rack key is out of range" do
    expect{ adapter.key_to_index("d1") }.to raise_error( AlphaNumericRackAdapter::KeyOutOfRangeError )
  end

  it "raise exception if rack key is out of range" do
    expect{ adapter.key_to_index("a0") }.to raise_error( AlphaNumericRackAdapter::KeyOutOfRangeError )
  end
end