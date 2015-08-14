require_relative '../simple_translator.rb'

describe SimpleTranslator do
  let('translator'){ SimpleTranslator.new( ['a','b','c','d','e'] ) }

  it "should use array of keys to find index from key" do
    expect( translator.key_to_index('c') ).to eq(2)
  end

  it "should use array of keys to find key from index" do
    expect( translator.index_to_key(3) ).to eq('d')
  end

  it "raise exception if rack key not found" do
    expect{ translator.key_to_index("z") }.to raise_error( SimpleTranslator::KeyNotFound )
  end

end