require_relative '../item_finder.rb'

describe ItemFinder do
  let(:item_finder){ item_finder = ItemFinder.new }

  before(:each) do
    item_finder.load_items( [ { position:0, name:"hats" }, { position:1, name:"shoes" } ] )
  end

  context "loading items" do
    it "should ask translator to translate the key" do
      translator = double('translator')
      item_finder.translator = translator
      expect( translator ).to receive(:key_to_index).with('KEY').and_return(0)
      item_finder.load_items( [ { position:"KEY", name:"hats" } ] )    
    end
  end

  context "showing items at locations" do
    it "should reveal items for a list of locations" do
      expect(item_finder.show_items_at_locations( [ 0, 1 ] ) ).to include( { 0 => "hats", 1 => "shoes" } )
    end

    it "should assign nil if no item at location" do
      expect(item_finder.show_items_at_locations( [ 0, 2 ] ) ).to eq( { 0 => "hats", 2 => nil } )
    end

    it "should ask translator to translate the keys" do
      translator = double('translator')
      item_finder.translator = translator
      expect( translator ).to receive(:key_to_index).with('KEY1').and_return(0)
      expect( translator ).to receive(:key_to_index).with('KEY2').and_return(1)
      item_finder.show_items_at_locations( [ 'KEY1', 'KEY2' ] )
    end
  end

  context "showing distance between locations" do 
    it "should use location calculator to calculate distance " do
      distance_calculator  = double('distance_calculator')
      item_finder.distance_calculator = distance_calculator
      expect( distance_calculator ).to receive(:distance_between_locations)
      item_finder.distance_between_locations( [ 0, 1 ] )
    end

    it "should by default use linear distance calculator " do
      expect( item_finder.instance_variable_get(:@distance_calculator).class)
      .to equal(ItemFinder::LinearDistanceCalculator)
    end

    context " linear distance calculator " do
      let(:distance_calculator) { ItemFinder::LinearDistanceCalculator.new }
      let(:translator) { double('translator') }
      let(:items) { ['a','b','c','d','e'] }
      
      it "should calculate distance as difference between indexes of the furthers items " do
        allow(translator).to receive(:key_to_index).with(3) { 3 }
        allow(translator).to receive(:key_to_index).with(1) { 1 }
        expect(distance_calculator.distance_between_locations( items, [ 3, 1 ], translator ) )
        .to eq( 2 )
      end

      it "should still show distance value even when item doesn't exist in location " do
        allow(translator).to receive(:key_to_index).with(0) { 0 }
        allow(translator).to receive(:key_to_index).with(9) { 9 }
        expect(distance_calculator.distance_between_locations( items, [ 0, 9 ] , translator ) ).to eq( 9 )
      end

      it "should ask translator to translate item names to indexs" do
        expect( translator ).to receive(:key_to_index).with('KEY1').and_return(0)
        expect( translator ).to receive(:key_to_index).with('KEY2').and_return(1)
        distance_calculator.distance_between_locations( items, [ 'KEY1', 'KEY2' ], translator )
      end
    end
  end

  context "finding the locations of items" do
    it "should find locations of multiple items" do
      expect( item_finder.find_locations_of_items( ["hats", "shoes"] ) ).to eq( { "hats" => 0, "shoes"=> 1 } )
    end

    it "should give location nil if item does not exist" do
      expect( item_finder.find_locations_of_items( ["sausages", "shoes"] ) ).to eq( { "sausages" => nil, "shoes"=> 1 } )
    end

    it "should ask translator to translate the index back to key" do
      translator = double('translator')
      item_finder.translator = translator
      expect( translator ).to receive(:index_to_key).with(0).and_return("KEY1")
      expect( translator ).to receive(:index_to_key).with(1).and_return("KEY2")
      item_finder.find_locations_of_items( ["hats", "shoes"] )
    end
  end

  context "showing the path to collect items" do
    it "should show the path required to collect items" do
      item_finder.load_items( [ { position:10, name:"gloves" } ] )
      expect( item_finder.path_for_items( ["gloves", "hats"] ) ).to eq( [ 0, 10 ] )
    end

    it "should ask translator to translate the index back to key" do
      item_finder.load_items( [ { position:10, name:"gloves" } ] )
      translator = double('translator')
      item_finder.translator = translator
      expect( translator ).to receive(:index_to_key).with(0).and_return("KEY1")
      expect( translator ).to receive(:index_to_key).with(10).and_return("KEY11")
      item_finder.path_for_items( ["gloves", "hats"] )
    end
  end


  context "showing the path to collect items" do 
    it "should use the path finder to find path " do
      path_finder  = double('path_finder')
      item_finder.path_finder = path_finder
      expect( path_finder ).to receive(:path_for_items)
      item_finder.path_for_items( [ 0, 1 ] )
    end

    it "should by default use linear path finder " do
      expect( item_finder.instance_variable_get(:@path_finder).class)
      .to equal(ItemFinder::LinearPathFinder)
    end

    context " linear path finder " do
      let(:path_finder) { ItemFinder::LinearPathFinder.new }
      let(:translator) { double('translator') }
      let(:items) { ['a','b','c','d','e'] }
      
      it "show path as the first position that is found to the last " do
        allow(translator).to receive(:index_to_key).with(4) { 4 }
        allow(translator).to receive(:index_to_key).with(1) { 1 }
        allow(translator).to receive(:index_to_key).with(2) { 2 }
        expect( path_finder.path_for_items( items, ["e", "b" , "c"], translator ) ).to eq( [ 1, 2, 4 ]  )
      end

      it "should return false for path if item cannot be found" do
        expect( item_finder.path_for_items( ["a", "z"] ) ).to eq( false )
      end

      it "should ask translator to translate the index back to key" do
        expect( translator ).to receive(:index_to_key).with(0).and_return("KEY1")
        expect( translator ).to receive(:index_to_key).with(3).and_return("KEY4")
        path_finder.path_for_items(items, ["a", "d"], translator )
      end
    end
  end



end