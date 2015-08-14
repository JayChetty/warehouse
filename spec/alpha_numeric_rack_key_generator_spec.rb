require_relative '../alpha_numeric_rack_key_generator.rb'
describe AlphaNumericRackKeyGenerator do
  it "should create key given rack keys and length" do
    expect( AlphaNumericRackKeyGenerator.generate_keys( ['a','b','c'], 2 ) )
    .to eq([ 'a1','a2','b1','b2','c1','c2' ])
  end

  it "should be able to invert rows" do
    expect( AlphaNumericRackKeyGenerator.generate_keys( ['a','b','c'], 2, ['a'] ) )
    .to eq([ 'a2','a1','b1','b2','c1','c2' ])
  end
end