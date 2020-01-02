# frozen_string_literal: true

# This is my implementation of some Ruby Enumerable module functions
module Enumerable
  def my_each
    return enum_for(:my_each) unless block_given?

    return_array = to_a

    (0...return_array.length).each do |i|
      yield(return_array[i])
    end

    return_array
  end

  def my_each_with_index
    return enum_for(:my_each_with_index) unless block_given?

    index = 0

    my_each do |element|
      yield(element, index)
      index += 1
    end
  end

  def my_select
    return enum_for(:my_select) unless block_given?

    return_array = []

    my_each do |element|
      return_array << element if yield(element)
    end

    return_array
  end

  def my_all?(argument = nil)
    if argument.class == Regexp
      my_each do |element|
        return false unless element.match(argument)
      end
    elsif argument
      my_each do |element|
        return false unless element.is_a?(argument)
      end
    elsif block_given?
      my_each do |element|
        return false unless yield(element)
      end
    else
      my_each do |element|
        return false unless element
      end
    end

    true
  end

  def my_any?(argument = nil)
    if argument.class == Regexp
      my_each do |element|
        return true unless element.match(argument).nil?
      end
    elsif argument
      my_each do |element|
        return true if element.is_a?(argument)
      end
    elsif block_given?
      my_each do |element|
        return true if yield(element)
      end
    else
      my_each do |element|
        return true if element
      end
    end

    false
  end

  def my_none?(argument = nil)
    if argument.is_a?(Regexp)
      my_each do |element|
        return false unless element.match(argument).nil?
      end
    elsif argument
      my_each do |element|
        return false if element.is_a?(argument)
      end
    elsif block_given?
      my_each do |element|
        return false if yield(element)
      end
    else
      my_each do |element|
        return false if element
      end
    end

    true
  end

  def my_count(argument = nil)
    counter = 0

    if argument
      my_each do |element|
        counter += 1 if element == argument
      end
    elsif block_given?
      my_each do |element|
        counter += 1 if yield(element)
      end
    else
      my_each do |element|
        counter += 1 if element
      end
    end

    counter
  end

  def my_map
    return enum_for(:my_map) unless block_given?

    return_array = []

    my_each do |element|
      return_array << yield(element)
    end

    return_array
  end

  def my_inject(*args)
    array = to_a
    initial_element = 0
    symbol = nil
    result = nil

    args.my_each do |argument|
      if argument.is_a? Numeric
        initial_element = argument
      else
        symbol = argument
      end
    end
    return enum_for(:my_inject) unless block_given? || !symbol.nil?

    result = array[initial_element]
    array.delete_at(initial_element)

    if symbol
      return array[-1] if symbol.to_s == '='

      array.my_each do |element|
        result = result.send(symbol.to_s, element)
      end
    else
      array.my_each do |element|
        result = yield(result, element)
      end
    end

    result
  end
end

# Tests required in the Odin Project webpage

# def multiply_els(array)
#   array.my_inject(:*)
# end
# puts multiply_els([2,4,5])

# floats = [1.2, 3.45, 0.91, 7.727, 11.42, 482.911]
# round_down = Proc.new { |x| x.floor }
# puts floats.my_map(&round_down)

# Tests from the ruby-doc.org

# array = [12, 2, 4, 56, 34]
# array.my_each { |int| print (int * 2).to_s + " " }
#
# (100..120).my_each do |int|
#   puts int - 5
# end

# hash = {}

# %w[cat dog wombat].my_each_with_index do |item, index|
#   hash[item] = index
# end

# puts "#{hash}"

# puts "#{(1..10).my_select { |i| i % 3 == 0 }}" #=> [3, 6, 9]
# puts "#{[11, 23, 3, 14, 5].my_select { |num|  num.even? }}"   #=> [14]
# puts "#{[:foo, :bar].my_select { |x| x == :foo }}"   #=> [:foo]

# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_all?(/t/)                        #=> false
# puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# puts [nil, true, 99].my_all?                              #=> false
# puts [].my_all? { |word| word.length >= 4 }               #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].my_any?                                           #=> false
# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts %w{ant bear cat}.my_none?(/d/)                        #=> true
# puts [1, 3.14, 42].my_none?(Float)                         #=> false
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true
# puts [nil, false, true].my_none?                           #=> false
# ary = [1, 2, 4, 2]
# puts ary.my_count               #=> 4
# puts ary.my_count(2)            #=> 2
# puts ary.my_count{ |x| x%2==0 } #=> 3

# puts (1..4).my_map { |i| i * i }.to_s             #=> [1, 4, 9, 16]
# puts [3, 23, 45, 34].my_map { |i| i * i }.to_s    #=> [9, 529, 2025, 1156]

# # Sum some numbers
# puts (5..10).my_inject(:+)                             #=> 45
# puts (5..10).my_inject { |sum, n| sum + n }            #=> 45

# # Multiply some numbers
# puts (5..10).my_inject(1, :*)                          #=> 151200
# puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200

# # find the longest word
# longest = %w[cat sheep bear].my_inject do |memo, word|
#   memo.length > word.length ? memo : word
# end
# puts longest #=> "sheep"
