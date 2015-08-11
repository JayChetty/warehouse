class AlphaNumericRackAdapter
  def initialize( item_finder, number_of_racks, rack_length, inverted_racks = [] )
    @item_finder = item_finder
    @number_of_racks = number_of_racks
    @rack_length = rack_length
    @inverted_racks = inverted_racks
  end
end