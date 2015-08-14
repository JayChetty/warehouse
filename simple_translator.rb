class SimpleTranslator

  class KeyNotFound < StandardError
  end

  def initialize(keys)
    @keys = keys
  end

  def key_to_index(key_to_find)
    key = @keys.find_index { | key | key_to_find == key }
    raise KeyNotFound if key == nil
    key
  end

  def index_to_key(index)
    @keys[index]
  end
  
end