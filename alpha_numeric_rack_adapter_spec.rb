require_relative('./alpha_numeric_rack_adapter.rb')

describe AlphaNumericRackAdapter do
  let(:item_finder){ double('finder') }
  let(:adapter){adapter = AlphaNumericRackAdapter.new( item_finder, 3, 10, [0,2] )}

  it "should convert alpha numeric strings to array indexes" do
    expect( adapter.alpha_numeric_string_to_index("A1") ).to eq(0)
  end

  it "should convert alpha numeric strings to array indexes" do
    expect( adapter.alpha_numeric_string_to_index("B1") ).to eq(10)
  end

  it "should convert alpha numeric strings to array indexes" do
    expect( adapter.alpha_numeric_string_to_index("C10") ).to eq(29)
  end

  it "should convert indexes to alpha numeric strings" do
    expect( adapter.index_to_alpha_numeric_string(0) ).to eq("A1")
  end

  it "should convert indexes to alpha numeric strings" do
    expect( adapter.index_to_alpha_numeric_string(10) ).to eq("B1")
  end

  it "should convert indexes to alpha numeric strings" do
    expect( adapter.index_to_alpha_numeric_string(29) ).to eq("C10")
  end

  # it "raise exeception if out of range" do
  #   expect( adapter.alpha_numeric_string_to_index("A0") ).to equal(29)
  # end

  it "should provide interface to load items using alpha numeric language" do
    expect( item_finder ).to receive(:load_items).with( [ { position:0, name:"hats" }, { position:10, name:"shoes" } ] )
    adapter.load_items( [ { position:"A1", name:"hats" }, { position:"B1", name:"shoes" } ] )
  end

  it "should provide interface to search locations with distance using alpha numeric language" do
    expect( item_finder ).to receive(:search_locations_with_distance).with( [ 0, 10 ] )
    adapter.search_locations_with_distance( [ "A1", "B1"] )
  end

  it "should provide interface to find items with path returned in alpha numeric language" do
    allow(item_finder).to receive(:find_items_with_path).with(['gloves', 'shoes']) do 
      { locations:{ "gloves" => 10, "shoes"=> 4 }, path: [ 4, 10 ] }
    end
    expect( adapter.find_items_with_path( ["gloves", "shoes"] ) ).to eq( locations:{ "gloves" => "B1", "shoes"=> "A5" }, path: [ "A5", "B1" ] )
  end
end