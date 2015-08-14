class AlphaNumericRackTranslator

  class KeyOutOfRangeError < StandardError
  end
  #uses first leter of key to find rack,  remainder of key to find position on rack
  #key of form [letter][number] (where number > 0)  eg a9, b111  (not accepted a0, ab5)
  def initialize( rack_keys, rack_length, reversed_racks = [] )
    @rack_keys = rack_keys
    @number_of_racks = @rack_keys.length
    @rack_length = rack_length
    @reversed_racks = reversed_racks
  end

  def key_to_index(string_code)
    rack_letter = string_code[0]
    rack_number = @rack_keys.find_index do |letter|
      rack_letter == letter
    end

    position_on_rack = string_code[1..-1].to_i
    position_on_rack = @rack_length - position_on_rack + 1 if is_reversed(rack_letter)

    rack_number_out_of_range = !rack_number || rack_number > @number_of_racks - 1
    position_out_of_range = position_on_rack < 1 || position_on_rack > @rack_length
    raise KeyOutOfRangeError if rack_number_out_of_range || position_out_of_range

    (rack_number * 10) + position_on_rack - 1
  end

  def index_to_key(index)
    rack = index/10
    rack_letter = @rack_keys[rack]

    position = index%10
    position = @rack_length - position - 1 if is_reversed(rack_letter)

    rack_letter + ( position + 1 ).to_s
  end

  private
    def is_reversed(rack_letter)
      @reversed_racks.include?(rack_letter)
    end

end