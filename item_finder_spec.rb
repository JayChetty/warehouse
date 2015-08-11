require_relative './item_finder.rb'

describe ItemFinder do
  it "should load multiple items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
  end

  it "should reveal items for a list of locations" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect(item_finder.search_locations( [ 0, 1 ] ) ).to include( { 0 => "hats", 1 => "shoes" } )
  end

  it "should assign nil if no item at location" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect(item_finder.search_locations( [ 0, 2 ] ) ).to include( { 0 => "hats", 2 => nil } )
  end

  it "should reveal items for a list of locations and show distance between them" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect(item_finder.seach_locations_with_distance( [ 0, 1 ] ) ).to include( items: { 0 => "hats", 1 => "shoes" }, distance: 1 )
  end

  it "should still show distance value even when item doesn't exist in location " do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect(item_finder.seach_locations_with_distance( [ 0, 2 ] ) ).to include( items: { 0 => "hats", 2 => nil }, distance: 2 )
  end

  it "should find multiple items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect( item_finder.find_items( ["hats", "shoes"] ) ).to include( { "hats" => 0, "shoes"=> 1 } )
  end

  it "should give location nil if item does not exist" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect( item_finder.find_items( ["sausages", "shoes"] ) ).to include( { "sausages" => nil, "shoes"=> 1 } )
  end

  it "should find items and show the path required to retrieve items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:1, name:"hats" }, { position:4, name:"shoes" }, { position:10, name:"gloves" } ] )
    expect( item_finder.find_items_with_path( ["gloves", "shoes"] ) ).to include( locations:{ "gloves" => 10, "shoes"=> 4 }, path: [ 4, 10 ] )
  end

  it "should return false for path if item cannot be found" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:1, name:"hats" }, { position:4, name:"shoes" }, { position:10, name:"gloves" } ] )
    expect( item_finder.find_items_with_path( ["sausages", "shoes"] ) ).to include( locations:{ "sausages" => nil, "shoes"=> 4 }, path: false)
  end
end