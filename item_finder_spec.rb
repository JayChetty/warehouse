require_relative './item_finder.rb'

describe ItemFinder do
  it "should load multiple items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
  end

  it "should find multiple items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect( item_finder.find_items( ["hats", "shoes"] ) ).to include( { "hats" => 0, "shoes"=> 1 } )
  end

  it "should give location nil if item doesn not exist" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
    expect( item_finder.find_items( ["gloves", "shoes"] ) ).to include( { "gloves" => nil, "shoes"=> 1 } )
  end

  it "should show the distance between a set of items" do
    item_finder = ItemFinder.new
    item_finder.load_items( [ { position:1, name:"hats" }, { position:4, name:"shoes" }, { position:10, name:"gloves" } ] )
    expect( item_finder.distance( ["gloves", "shoes"] ) ).to equal(6)
  end

end