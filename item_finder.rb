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
end