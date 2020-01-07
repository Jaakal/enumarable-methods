# frozen_string_literal: true

require "./enumerable.rb"

describe Enumerable do
  describe ".my_each" do
    it "returns product of each item in array" do
      expect([2, 3, 4].my_each { |i| i * 2 }).to eql([4, 6, 8])
    end
  end

  describe ".my_each_with_index" do
    it "returns a hash with indexes of each item in array" do
      hash = {}
      %w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index }
      expect(hash).to eql({ "cat" => 0, "dog" => 1, "wombat" => 2 })
    end
  end
end
