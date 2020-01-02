# frozen_string_literal: true

module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    each do |i|
      yield(i)
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

    self.my_each { |i| return_array << i if yield(i) }
=begin
    each do |i|
      return_array << i if yield(i)
    end
=end
    return_array
  end

  def my_all?(argument = nil)
    (0...length).each do |i|
      if argument.class == Regexp
        self[i].match(argument) ? next : (return false)
      elsif argument
        (self[i].is_a? argument) ? next : (return false)
      end
      unless block_given?
        self[i] ? next : (return false)
      end
      next if yield(self[i])

      return false
    end

    true
  end

  def my_any?(argument = nil)
    (0...length).each do |i|
      if argument.class == Regexp
        !self[i].match(argument).nil? ? (return true) : next
      elsif argument
        (self[i].is_a? argument) ? (return true) : next
      end
      unless block_given?
        self[i] ? (return true) : next
      end
      return true if yield(self[i])
    end

    false
  end

  def my_none?(argument = nil)
    (0...length).each do |i|
      if argument.class == Regexp
        !self[i].match(argument).nil? ? (return false) : next
      elsif argument
        (self[i].is_a? argument) ? (return false) : next
      end
      unless block_given?
        self[i] ? (return false) : next
      end
      return false if yield(self[i])
    end

    true
  end

  def my_count(argument = nil)
    counter = 0
    (0...length).each do |i|
      if argument
        counter += 1 if self[i] == argument 
        next
      end
      unless block_given?
        counter += 1 if self[i]
        next
      end
      counter += 1 if yield(self[i])
    end

    counter
  end

  def my_map
    return enum_for(:my_map) unless block_given?

    array = []

    for element in self do
      array.push(yield(element))
    end

    array
  end
end

=begin
array = [12, 2, 4, 56, 34]
array.my_each do |int|
  puts int * 2
end
=end

=begin
hash = {}

%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end

puts "#{hash}"
=end

=begin
puts (1..10).my_select { |i| i % 3 == 0 } #=> [3, 6, 9]
puts [11,23,3,14,5].my_select { |num|  num.even?  }   #=> [2, 4]
puts [:foo, :bar].my_select { |x| x == :foo }   #=> [:foo]
=end

=begin
puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
puts %w[ant bear cat].my_all?(/t/)                        #=> false
puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
puts [nil, true, 99].my_all?                              #=> false
puts [].my_all? { |word| word.length >= 4 }                                          #=> true
=end

=begin
puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
puts %w[ant bear cat].my_any?(/d/)                        #=> false
puts [nil, true, 99].my_any?(Integer)                     #=> true
puts [nil, true, 99].my_any?                              #=> true
puts [].my_any?                                           #=> false
=end

=begin
puts %w{ant bear cat}.none? { |word| word.length == 5 } #=> true
puts %w{ant bear cat}.none? { |word| word.length >= 4 } #=> false
puts %w{ant bear cat}.none?(/d/)                        #=> true
puts [1, 3.14, 42].none?(Float)                         #=> false
puts [].none?                                           #=> true
puts [nil].none?                                        #=> true
puts [nil, false].none?                                 #=> true
puts [nil, false, true].none?                           #=> false
=end

=begin
ary = [1, 2, 4, 2]
puts ary.my_count               #=> 4
puts ary.my_count(2)            #=> 2
puts ary.my_count{ |x| x%2==0 } #=> 3
=end

puts (1..4).my_map { |i| i * i }.to_s
puts [3, 23, 45, 34].my_map { |i| i * i }.to_s