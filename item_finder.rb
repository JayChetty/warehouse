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

  def distance_between_items(item_names)
    locations = item_names.map do |item_name|
      @items.find_index do |item|
        item == item_name
      end
    end
    distance_for_locations(locations)
  end

  def distance_for_locations(locations)
    begin
      locations.max - locations.min
    rescue ArgumentError
      false
    end
  end
end