class ItemFinderAdapter 
  # abstract class,  override key_to_index, index_to_key to provide alternative interface to an item_finder
  
  def initialize( item_finder )
  end

  def key_to_index(key_string)
  end

  def index_to_key(index)
  end

  def load_items(items_to_load)
    items_to_load.each do |item|
      item[:position] = key_to_index(item[:position])
    end
    @item_finder.load_items(items_to_load)
  end

  def search_locations_with_distance(locations)
    indexs = locations.map do |location|
      key_to_index(location)
    end
    index_items_with_distance = @item_finder.search_locations_with_distance(indexs)
    alpha_numeric_items = {}
    index_items_with_distance[:items].each do |k,v|
      alpha_numeric_items[index_to_key(k)] = v
    end
    { items: alpha_numeric_items, distance: index_items_with_distance[:distance]}
  end

  def find_items_with_path(item_names)
    indexed_values = @item_finder.find_items_with_path(item_names)
    alpha_locations = {}
    indexed_values[:locations].each do |k,v|
      alpha_locations[k] = index_to_key(v)
    end
    alpha_path = indexed_values[:path].map do |index|
      index_to_key(index)
    end
    { locations: alpha_locations, path: alpha_path }
  end

  class KeyOutOfRangeError < StandardError
  end

end