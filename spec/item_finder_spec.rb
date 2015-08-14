require_relative '../item_finder.rb'



describe ItemFinder do
  let(:item_finder){ item_finder = ItemFinder.new }

  before(:each) do
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
  end

  context "showing items at locations" do

    it "should reveal items for a list of locations" do
      expect(item_finder.show_items_at_locations( [ 0, 1 ] ) ).to include( { 0 => "hats", 1 => "shoes" } )
    end

    it "should assign nil if no item at location" do
      expect(item_finder.show_items_at_locations( [ 0, 2 ] ) ).to eq( { 0 => "hats", 2 => nil } )
    end

  end

  context "showing distance between locations" do 

    it "should show distance between a list of locations" do
      expect(item_finder.distance_between_locations( [ 0, 1 ] ) ).to eq( 1 )
    end

    it "should still show distance value even when item doesn't exist in location " do
      expect(item_finder.distance_between_locations( [ 0, 2 ] ) ).to eq( 2 )
    end

  end

  context "finding the locations of items" do

    it "should find locations of multiple items" do
      expect( item_finder.find_locations_of_items( ["hats", "shoes"] ) ).to eq( { "hats" => 0, "shoes"=> 1 } )
    end

    it "should give location nil if item does not exist" do
      expect( item_finder.find_locations_of_items( ["sausages", "shoes"] ) ).to eq( { "sausages" => nil, "shoes"=> 1 } )
    end

  end

  context "showing the path to collect items" do

    it "should show the path required to collect items" do
      item_finder.load_items( [ { position:10, name:"gloves" } ] )
      expect( item_finder.path_for_items( ["gloves", "hats"] ) ).to eq( [ 0, 10 ] )
    end

    it "should return false for path if item cannot be found" do
      expect( item_finder.path_for_items( ["sausages", "shoes"] ) ).to eq( false )
    end

  end


end