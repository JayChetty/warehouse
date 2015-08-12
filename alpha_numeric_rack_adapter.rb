class AlphaNumericRackAdapter
  def initialize( item_finder, number_of_racks, rack_length, reversed_racks = [] )
    @item_finder = item_finder
    @number_of_racks = number_of_racks
    @rack_length = rack_length
    @reversed_racks = reversed_racks
    @letter_array = ("a".."z").to_a()
  end

  def alpha_numeric_string_to_index(string_code)
    rack_letter = string_code[0]
    rack_number = @letter_array.find_index do |letter|
      rack_letter == letter
    end

    position_on_rack = string_code[1..-1].to_i
    position_on_rack = @rack_length - position_on_rack + 1 if is_reversed(rack_letter)

    rack_number_out_of_range = !rack_number || rack_number > @number_of_racks - 1
    position_out_of_range = position_on_rack < 1 || position_on_rack > @rack_length
    raise KeyOutOfRangeError if rack_number_out_of_range || position_out_of_range

    (rack_number * 10) + position_on_rack - 1
  end

  def index_to_alpha_numeric_string(index)
    rack = index/10
    rack_letter = @letter_array[rack]

    position = index%10
    position = @rack_length - position - 1 if is_reversed(rack_letter)

    rack_letter + ( position + 1 ).to_s
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
    index_items_with_distance = @item_finder.search_locations_with_distance(indexs)
    alpha_numeric_items = {}
    index_items_with_distance[:items].each do |k,v|
      alpha_numeric_items[index_to_alpha_numeric_string(k)] = v
    end
    { items: alpha_numeric_items, distance: index_items_with_distance[:distance]}
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

  class KeyOutOfRangeError < StandardError
  end

  private
    def is_reversed(rack_letter)
      @reversed_racks.include?(rack_letter)
    end

end