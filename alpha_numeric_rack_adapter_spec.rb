require_relative('./alpha_numeric_rack_adapter.rb')

describe AlphaNumericRackAdapter do
  let(:item_finder){ double('finder') }
  let(:adapter){adapter = AlphaNumericRackAdapter.new( item_finder, ['a','b','c'], 10 )}

  it "should convert alpha numeric strings to array indexes" do
    expect( adapter.key_to_index("a1") ).to eq(0)
    expect( adapter.key_to_index("b1") ).to eq(10)
    expect( adapter.key_to_index("c10") ).to eq(29)
  end

  it "should alter number of reversed racks if stated" do
    adapter_with_inversion = AlphaNumericRackAdapter.new( item_finder, ['a','b','c'], 10, [ 'a','c' ] )
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
    adapter_with_inversion = AlphaNumericRackAdapter.new( item_finder, ['a','b','c'], 10, [ 'a','c' ] )
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

  it "should provide interface to load items using alpha numeric language" do
    expect( item_finder ).to receive(:load_items).with( [ { position:0, name:"hats" }, { position:10, name:"shoes" } ] )
    adapter.load_items( [ { position:"a1", name:"hats" }, { position:"b1", name:"shoes" } ] )
  end

  it "should provide interface to search locations with distance using alpha numeric language" do
    expect( item_finder ).to receive(:search_locations_with_distance).with( [ 0, 10 ] ) {
      { items:{ 0 => "shoes", 10 => "hats" }, distance:  10  }
    }
    adapter.search_locations_with_distance( [ "a1", "b1"] )
  end


  it "should return items with alphanumeric locations" do
    allow( item_finder ).to receive(:search_locations_with_distance).with( [ 0, 10 ] ) do
      { items:{ 0 => "shoes", 10 => "hats" }, distance:  10  }
    end
    expect( adapter.search_locations_with_distance( [ "a1", "b1"] ) )
      .to eq( items: { "a1" => "shoes", "b1" => "hats",}, distance: 10 )
  end

  it "should provide interface to find items with path returned in alpha numeric language" do
    allow(item_finder).to receive(:find_items_with_path).with(['gloves', 'shoes']) do 
      { locations:{ "gloves" => 10, "shoes"=> 4 }, path: [ 4, 10 ] }
    end
    expect( adapter.find_items_with_path( ["gloves", "shoes"] ) ).to eq( locations:{ "gloves" => "b1", "shoes"=> "a5" }, path: [ "a5", "b1" ] )
  end
end