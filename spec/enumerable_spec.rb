# frozen_string_literal: true

require "./enumerable.rb"

describe Enumerable do
  describe "#my_each" do
    it 'returns enumerator if no block given' do
      expect([2, 3, 4].my_each.inspect).to eql([2, 3, 4].to_enum(:my_each).inspect)
    end

    it "returns product of each item in array" do
      expect([2, 3, 4].my_each { |i| i * 2 }).to eql([4, 6, 8])
    end

  end

  describe "#my_each_with_index" do
    it 'returns enumerator if no block given' do
      expect(%w[cat dog wombat].my_each_with_index.inspect).to eql(%w[cat dog wombat].
        to_enum(:my_each_with_index).inspect)
    end

    it "returns a hash with array elements as keys and indexes as values" do
      hash = {}
      %w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
      expect(hash).to eql({ "cat" => 0, "dog" => 1, "wombat" => 2 })
    end
  end

  describe '#my_select' do
    it 'returns enumerator if no block given' do
      expect([2, 3, 4].my_select.inspect).to eql([2, 3, 4].to_enum(:my_select).inspect)
    end

    it 'return array which elements divide with three from range' do
      expect((1..10).my_select { |i| i % 3 == 0 }).to eql([3, 6, 9])
    end

    it 'return array which elements are even from array' do
      expect([11, 23, 3, 14, 5].my_select { |num|  num.even? }).to eql([14])
    end

    it 'return array of symbols :foo from array' do
      expect([:foo, :bar, :foo].my_select { |x| x == :foo }).to eql([:foo, :foo])
    end
  end

  describe '#my_all' do
    it 'return true if every word length in [ant, bear, cat] is three or more' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return false if every word length in [ant, bear, cat] is four or more' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to eql(false)
    end

    it "return false if every word isn't in [ant, bear, cat] targetable by /t/" do
      expect(%w[ant bear cat].my_all?(/t/)).to eql(false)
    end

    it "return true if every word is targetable in [ant, bear, cat] by /a/" do
      expect(%w[ant bear cat].my_all?(/a/)).to eql(true)
    end

    it 'return true if all are numeric in [1, 2i, 3.14]' do
      expect([1, 2i, 3.14].my_all?(Numeric)).to eql(true)
    end

    it "return false if all ain't numeric in [1, i, 3.14]" do
      expect([1, 'i', 3.14].my_all?(Numeric)).to eql(false)
    end

    it "return false if all the elements in [nil, true, 99]
      aren't else than nil or false" do
      expect([nil, true, 99].my_all?).to eql(false)
    end

    it "return true if all the elements in [i, true, 99] are 
        else than nil or false" do
      expect(['i', true, 99].my_all?).to eql(true)
    end
  end

  describe '#my_any' do
    it 'return true if any word length in [ant, bear, cat] is three or more' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 3 }).to eql(true)
    end

    it 'return false if any word length in [ant, bear, cat] is four or more' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to eql(true)
    end
    
    it "return false if any word isn't in [ant, bear, cat] targetable by /d/" do
      expect(%w[ant bear cat].my_any?(/d/)).to eql(false)
    end

    it "return true if any word is targetable in [ant, bear, cat] by /c/" do
      expect(%w[ant bear cat].my_any?(/c/)).to eql(true)
    end
    
    it 'return true if any in [nil, true, 99] is type Integer' do
      expect([nil, true, 99].my_any?(Integer)).to eql(true)
    end
    
    it "return false if any in [nil, true, 3.14] isn't Integer" do
      expect([nil, true, 3.14].my_any?(Integer)).to eql(false)
    end
    
    it "return true if any of the elements in [nil, true, 99]
      is else than nil or false" do
      expect([nil, true, 99].my_any?).to eql(true)
    end
  
    it "return false if any of the elements in [false, nil, false] isn't 
        else than nil or false" do
      expect([false, nil, false].my_all?).to eql(false)
    end
  end

  describe '#my_none' do
    # puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
    # puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
    # puts %w{ant bear cat}.my_none?(/d/)                        #=> true
    # puts [1, 3.14, 42].my_none?(Float)                         #=> false
    # puts [].my_none?                                           #=> true
    # puts [nil].my_none?                                        #=> true
    # puts [nil, false].my_none?                                 #=> true
    # puts [nil, false, true].my_none?     

    it 'true if no word in [ant, bear, cat] has length equal to 5' do
      expect(['ant', 'bear', 'cat'].my_none? { |word| word.length == 5 }).to eql(true)
    end

    it 'false if any word in [ant, bear, cat] has length equal to 4 or more' do
      expect(['ant', 'bear', 'cat'].my_none? { |word| word.length >= 4 }).to eql(false)
    end
  end
end
