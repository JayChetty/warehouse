class SimpleTranslator

  class KeyNotFound < StandardError
  end

  def initialize(keys)
    @keys = keys
  end

  def key_to_index(key_to_find)
    index = @keys.find_index { | key | key_to_find == key }
    raise KeyNotFound if index == nil
    index
  end

  def index_to_key(index)
    @keys[index]
  end
  
end