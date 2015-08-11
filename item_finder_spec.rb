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
end