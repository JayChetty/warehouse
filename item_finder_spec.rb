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

  it "should show the distance between a set of items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:1, name:"hats" }, { position:4, name:"shoes" }, { position:10, name:"gloves" } ] )
    expect( item_finder.distance_between_items( ["gloves", "shoes"] ) ).to equal(6)
  end

  it "should return false for distance if item is missing" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:1, name:"hats" }, { position:4, name:"shoes" }, { position:10, name:"gloves" } ] )
    expect( item_finder.distance_between_items( ["sausages", "shoes"] ) ).to equal(false)
  end

end