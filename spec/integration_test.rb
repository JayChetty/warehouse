#integration test,  using the spec given for the warehouse picker exercise
require_relative '../item_finder.rb'
require_relative '../alpha_numeric_rack_adapter.rb'

describe "WarehousePickerIntegrationTest"  do
  let(:item_finder){ ItemFinder.new }
  let(:adapter){adapter = AlphaNumericRackAdapter.new( item_finder, ['a','c','b'], 10, ['a'] ) }
  before(:each) do
    adapter.load_items( [
      { name: 'bath fizzers'  , position: 'b7' },
      { name: 'blouse'        , position: 'a3' },
      { name: 'bookmark'      , position: 'a7' },
      { name: 'candy wrapper' , position: 'c8' },
      { name: 'chalk'         , position: 'c3' },
      { name: 'cookie jar'    , position: 'b10' },
      { name: 'deodorant'     , position: 'b9' },
      { name: 'drill press'   , position: 'c2' },
      { name: 'face wash'     , position: 'c6' },
      { name: 'glow stick '   , position: 'a9' },
      { name: 'hanger'        , position: 'a4' },
      { name: 'leg warmers'   , position: 'c10' },
      { name: 'model car'     , position: 'a8' },
      { name: 'nail filer'    , position: 'b5' },
      { name: 'needle'        , position: 'a1' },
      { name: 'paint brush'   , position: 'c7' },
      { name: 'photo album'   , position: 'b4' },
      { name: 'picture frame' , position: 'b3' },
      { name: 'rubber band'   , position: 'a10' },
      { name: 'rubber duck'   , position: 'a5' },
      { name: 'rusty nail'    , position: 'c1' },
      { name: 'sharpie'       , position: 'b2' },
      { name: 'shoe lace'     , position: 'c9' },
      { name: 'shovel'        , position: 'a6' },
      { name: 'stop sign'     , position: 'a2' },
      { name: 'thermometer'   , position: 'c5' },
      { name: 'tire swing'    , position: 'b1' },
      { name: 'tissue box'    , position: 'b8' },
      { name: 'tooth paste'   , position: 'b6' },
      { name: 'word search'   , position: 'c4' }
    ])
  end

  it "given b5, b10, and b6, determine that the products are nail filer, cookie jar, and tooth paste, and they're five bays apart" do
     expect( adapter.search_locations_with_distance( [ "b5", "b10", "b6"] ) )
     .to eq items: { "b5" => "nail filer", "b10" => "cookie jar", "b6" => "tooth paste" }, distance: 5
  end

  it 'given "b3, c7, c9 and a3", determine that the products are "picture frame, paint brush, shoe lace, and blouse", and theyre 15 bays apart' do
     expect( adapter.search_locations_with_distance( [ "b3", "c7", "c9", "a3"] ) )
     .to eq items: { "b3" => "picture frame", "c7" => "paint brush", "c9" => "shoe lace", "a3"=>"blouse" }, distance: 15
  end

  it 'given "shoe lace, rusty nail, leg warmers", determine that those items need to be collected from "c1, c9, and c10"' do
    expect( adapter.find_items_with_path( ["shoe lace", "rusty nail", "leg warmers"] ) )
    .to eq locations:{ "shoe lace" => "c9", "rusty nail"=> "c1", "leg warmers"=> "c10" }, path: [ "c1", "c9", "c10" ]
  end

  it 'given "hanger, deodorant, candy wrapper, rubber band", determine that those items need to be collected from "a10, a4, c8, and b9"' do
    expect( adapter.find_items_with_path( ["hanger", "deodorant", "candy wrapper", "rubber band"] ) )
    .to eq locations:{ "hanger" => "a4", "deodorant"=> "b9", "candy wrapper"=> "c8", "rubber band"=>"a10" }, path: [ "a10", "a4", "c8", "b9" ]
  end

end