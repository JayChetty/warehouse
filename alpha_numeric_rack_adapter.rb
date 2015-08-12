class AlphaNumericRackAdapter
  def initialize( item_finder, number_of_racks, rack_length, inverted_racks = [] )
    @item_finder = item_finder
    @number_of_racks = number_of_racks
    @rack_length = rack_length
    @inverted_racks = inverted_racks
    @letter_array = ("A".."Z").to_a()
  end

  def alpha_numeric_string_to_index(string_code)
    rack_letter = string_code[0]
    rack_number = @letter_array.find_index do |letter|
      rack_letter == letter
    end
    position_on_rack = string_code[1..-1].to_i - 1
    (rack_number * 10) + position_on_rack
  end

  def index_to_alpha_numeric_string(index)
    rack = index/10
    position = index%10 + 1
    @letter_array[rack] + position.to_s
  end

  def load_items(items_to_load)
    items_to_load.each do |item|
      item[:position] = alpha_numeric_string_to_index(item[:position])
    end
    @item_finder.load_items(items_to_load)
  end

  def search_locations_with_distance(locations)
    indexs = locations.map do |location|
      alpha_numeric_string_to_index(location)
    end
    @item_finder.search_locations_with_distance(indexs)
  end

  def find_items_with_path(item_names)
    indexed_values = @item_finder.find_items_with_path(item_names)
    alpha_locations = {}
    indexed_values[:locations].each do |k,v|
      alpha_locations[k] = index_to_alpha_numeric_string(v)
    end
    alpha_path = indexed_values[:path].map do |index|
      index_to_alpha_numeric_string(index)
    end
    { locations: alpha_locations, path: alpha_path }
  end

end