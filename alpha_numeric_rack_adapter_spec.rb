require_relative('./alpha_numeric_rack_adapter.rb')

describe AlphaNumericRackAdapter do
  let(:item_finder){ double('finder') }
  it "should be created with an item finder, number of racks, rack length, and inverted columns" do
    adapter = AlphaNumericRackAdapter.new( item_finder, 3, 10, [0,2] )
  end
end