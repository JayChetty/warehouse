class ItemFinder
  class BasicTranslator
    def key_to_index(key)
      key
    end

    def index_to_key(index)
      index
    end
  end

  class LinearDistanceCalculator
    def distance_between_locations(items, locations, translator)
      indexed_locations = locations.map { |location| translator.key_to_index( location ) }
      indexed_locations.max - indexed_locations.min
    end
  end

  class LinearPathFinder
    def path_for_items(items, item_names, translator)
      indexed_locations = item_names.map do |item_name|
        items.find_index { |item| item == item_name }
      end
      return false if indexed_locations.include?(nil)
      indexed_locations.sort!
      indexed_locations.map { |index| translator.index_to_key( index ) }
    end
  end

  attr_writer :translator, :distance_calculator, :path_finder

  def initialize(options = {})
    @items = []
    @translator = options[:translator] || BasicTranslator.new
    @distance_calculator = options[:distance_calculator] || LinearDistanceCalculator.new
    @path_finder = options[:path_finder] || LinearPathFinder.new
  end

  def load_items(items_to_load)
    items_to_load.each do |item|
      @items[ @translator.key_to_index( item[:position] ) ] = item[:name]
    end
  end

  def show_items_at_locations(locations)
    result = {}
    locations.each do |location|
      result[location] = @items[ @translator.key_to_index( location ) ]
    end
    result
  end

  def distance_between_locations(locations)
    @distance_calculator.distance_between_locations(@items, locations, @translator)
  end

  def show_items_at_locations_and_distance(locations)
    {items: show_items_at_locations(locations), distance: distance_between_locations( locations )}
  end

  def find_locations_of_items(item_names)
    locations = {}
    item_names.each do |item_name|
      index = @items.find_index do |item|
        item == item_name
      end
      locations[item_name] = @translator.index_to_key(index)
    end
    locations
  end

  def path_for_items(item_names)
    @path_finder.path_for_items(@items, item_names, @translator)
  end

  def find_locations_of_items_with_path(item_names)
    {locations: find_locations_of_items( item_names ), path: path_for_items( item_names )}
  end

end