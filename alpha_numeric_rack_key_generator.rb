class AlphaNumericRackKeyGenerator
  def self.generate_keys(rack_keys, length, inverted_rows = [])
    keys = []
    rack_keys.each do |key|
      nums = (1..length).to_a
      nums.reverse! if inverted_rows.include?(key)
      nums.each do |num|
        keys.push(key + num.to_s)
      end
    end
    keys
  end
end