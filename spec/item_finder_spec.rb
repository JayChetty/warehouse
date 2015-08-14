require_relative '../item_finder.rb'



describe ItemFinder do
  let(:item_finder){ item_finder = ItemFinder.new }

  before(:each) do
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
  end

  it "should reveal items for a list of locations" do
    expect(item_finder.search_locations( [ 0, 1 ] ) ).to include( { 0 => "hats", 1 => "shoes" } )
  end

  it "should assign nil if no item at location" do
    expect(item_finder.search_locations( [ 0, 2 ] ) ).to eq( { 0 => "hats", 2 => nil } )
  end

  it "should reveal items for a list of locations and show distance between them" do
    expect(item_finder.search_locations_with_distance( [ 0, 1 ] ) ).to eq( items: { 0 => "hats", 1 => "shoes" }, distance: 1 )
  end

  it "should still show distance value even when item doesn't exist in location " do
    expect(item_finder.search_locations_with_distance( [ 0, 2 ] ) ).to eq( items: { 0 => "hats", 2 => nil }, distance: 2 )
  end

  it "should find multiple items" do
    expect( item_finder.find_items( ["hats", "shoes"] ) ).to eq( { "hats" => 0, "shoes"=> 1 } )
  end

  it "should give location nil if item does not exist" do
    expect( item_finder.find_items( ["sausages", "shoes"] ) ).to eq( { "sausages" => nil, "shoes"=> 1 } )
  end

  context "finding items with path" do

    before(:each) do
      item_finder.load_items( [ { position:10, name:"gloves" } ] )
    end

    it "should find items and show the path required to retrieve items" do
      expect( item_finder.find_items_with_path( ["gloves", "shoes"] ) ).to eq( locations:{ "gloves" => 10, "shoes"=> 1 }, path: [ 1, 10 ] )
    end

    it "should return false for path if item cannot be found" do
      expect( item_finder.find_items_with_path( ["sausages", "shoes"] ) ).to eq( locations:{ "sausages" => nil, "shoes"=> 1 }, path: false)
    end

  end
end