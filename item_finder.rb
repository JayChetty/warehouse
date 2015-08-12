class ItemFinder
  def initialize
    @items = []
  end

  def load_items(items_to_load)
    #example item { position:1, name: "hats" }
    items_to_load.each do |item|
      @items[ item[:position] ] = item[:name]
    end
  end

  def search_locations(locations)
    result = {}
    locations.each do |location|
      result[location] = @items[location]
    end
    result
  end

  def search_locations_with_distance(locations)
    items = search_locations(locations)
    distance = locations.max - locations.min
    {items: items, distance: distance}
  end

  def find_items(item_names)
    locations = {}
    item_names.each do |item_name|
      index = @items.find_index do |item|
        item == item_name
      end
      locations[item_name] = index
    end
    locations
  end

  def find_items_with_path(item_names)
    locations = find_items(item_names)
    if locations.has_value?(nil)
      path = false
    else
      path = locations.values.sort
    end
    {locations: locations, path: path}
  end

end