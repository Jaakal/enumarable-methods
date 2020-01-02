# Enumerable Methods

This is a copy of Ruby Enumerable module with some if its methods.

## Getting Started

One can either download the enumerable.rb and include it to its project or just copy the code from the enumerable.rb file into ones project.

**Example for my_each:**
```
[12, 2, 4, 56, 34].my_each { |int| print (int * 2).to_s + " " } => 24 4 8 112 68
```

**Example for my_each_with_index:**
```
hash = {}
%w[cat dog wombat].my_each_with_index { |item, index| hash[item] = index } => {"cat"=>0, "dog"=>1, "wombat"=>2}
```

**Example for my_select:**
```
(1..10).my_select { |i| i % 3 == 0 } => [3, 6, 9]
```

**Example for my_all?:**
```
[1, 2i, 3.14].my_all?(Numeric) => true
```

**Example for my_any?:**
```
%w[ant bear cat].my_any?(/d/) => false
```

**Example for my_none?:**
```
%w{ant bear cat}.my_none? { |word| word.length == 5 } => true
```

**Example for my_count:**
```
[1, 2, 4, 2].my_count{ |x| x % 2 == 0 } => 3
```

**Example for my_map:**
```
[3, 23, 45, 34].my_map { |i| i * i } => [9, 529, 2025, 1156]
```

**Example for my_inject:**
```
(5..10).my_inject(1) { |product, n| product * n } => 151200
```

### Prerequisites

Ruby needs to be installed before one is able to run Ruby code in its computer.

## Built With

* [Ruby](https://www.ruby-lang.org/en/) - Programming language used
* [VS Code](https://code.visualstudio.com/) - The code editor used

## Authors

* **Jaak Kivinukk** - *Initial work* - [Jaakal](https://github.com/Jaakal)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

