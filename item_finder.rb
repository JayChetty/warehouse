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

  def distance(item_names)
    locations = item_names.map do |item_name|
      @items.find_index do |item|
        item == item_name
      end
    end
    locations.max - locations.min
  end
end