# frozen_string_literal: true

module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    (0...length).each do |i|
      yield(self[i])
    end
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    (0...length).each do |i|
      yield(self[i], i)
    end
  end

  def my_select
    return enum_for(:my_select) unless block_given?

    return_array = []

    for i in self do
      return_array << i if yield(i)
    end

    return_array
  end

  def my_all
    (0...length).each do |i|
        unless block_given?
          self[i].nil? && self ? next : return false
        end
        next unless yield(self[i])

        return false
    end
  end
end

array = [12, 2, 4, 56, 34]
# array.my_each do |int|
#   puts int * 2
# end
# hash = {}
#
# %w[cat dog wombat].my_each_with_index do |item, index|
#   hash[item] = index
# end
#
# puts "#{hash}"

#puts (1..10).my_select { |i| i % 3 == 0 } #=> [3, 6, 9]

#puts [11,23,3,14,5].my_select { |num|  num.even?  }   #=> [2, 4]

# puts [:foo, :bar].my_select { |x| x == :foo }   #=> [:foo]

puts %w[ant bear cat].all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].all?(/t/)                        #=> false
puts [1, 2i, 3.14].all?(Numeric)                       #=> true
puts [nil, true, 99].all?                              #=> false
puts [].all?