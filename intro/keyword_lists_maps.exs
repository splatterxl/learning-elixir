# -- keyword lists --

# to split strings into a list of characters, we use the String.split/2 function
String.split("hello world", " ") # => ["hello", "world"]

# but look what happens if there's more than one space next to each other 
String.split("hello  world", " ") # => ["hello", "", "world"]

# luckily, String.split/3 allows us to specify to trim the whitespace
String.split("hello  world", " ", [trim: true]) # => ["hello", "world"]

# that's a keyword list. it's a list of keywords, and you can use them to specify options
# furthermore, if it's at the end of a function call, we can skip the brackets! 

String.split("hello  world", " ", trim: true) # => ["hello", "world"] 

# simply put, keyword lists are lists of 2-element tuples, where the first element is an atom 
# of the option name and the second element is its value 

# therefore, 
[{ :trim, true }] == [trim: true] # => true 

# since keyword lists are lists, you can use any list operator on them 
opts = [a: true, b: false] ++ [c: 1] # => [a: true, b: false, c: 1] 

# we can also retrieve the value of a keyword list using bracket syntax: 
opts[:a] # => true 

# if there are duplicate options, the last one is used
opts = [a: true, a: false] 
opts[:a] # => false 

# keyword lists are important because of 3 special characteristics: 
#   1. keys must be atoms 
#   2. keys are ordered as specified by the developer
#   3. keys can be given more than once 

# we can pattern match on keyword lists, but it's rare because the order has to be the same 

# in order to manipulate keyword lists, we use the Keyword module 
# https://hexdocs.pm/elixir/Keyword.html

# remember that keyword lists are still lists, and they provide the same linear performance characteristics 
# -> the longer the list, the longer it takes to traverse the elements 

# for this reason, we use keyword lists when we need to specify optional options 

# -- maps -- 

# maps are the "go to" structure for storing key-value pairs in elixir 
# they are created using %{} syntax 
map = %{:a => 1, 2 => :b}

# you can access the value of a map using the [] operator 
map[:a] # => 1 
map[2] # => :b 

# printing the map will output its contents in a human-readable format
inspect(map) # => "%{2 => :b, :a => 1}"

# we can already see the differences between maps and keyword lists 
#   1. maps allow any key to be used, whereas keyword lists only allow atoms 
#   2. maps' keys do not follow any order, whereas keyword lists' keys are ordered 

# in contrast with lists, maps are very useful for pattern matching
%{} = map # won't error, would error with its list equivalent
%{:a => a} = map # won't error error either 

# variables can also be used when creating maps and accessing them
a = 1
n = 3
map = %{:a => a, n => :b} # => %{3 => :b, :a => 1} 

map[n] # => :b

# the Map module (https://hexdocs.pm/elixir/Map.html) provides a similar API to the Keyword module, 
# with conveniences for working with maps 

Map.put(map, :c, 3) # => {3 => :b, :a => 1, :c => 3} 
Map.get(map, :a) # => 1 

# you can also set a value in a map using the following syntax 
%{map | :a => 2} # => {2 => :b, :a => 2, :c => 3}

# this depends on the key already being there, though. if you want to set a value that doesn't exist yet,
# you can use the Map.put/3 function 
Map.put(map, :d, 4) # => {3 => :b, :a => 1, :c => 3, :d => 4} 

# when all the keys in a map are atoms, you can use the keyword syntax 
%{a: 1, b: 2} # => %{:a => 1, :b => 2} 

# another interesting feature of maps is that they have their own syntax of accessing values 
map.a # => 1 

# map.e would be a KeyError, since it doesn't exist

# a quick note: do blocks, which are used to define functions, are also keyword lists 
if true do 
  "this will be seen"
else 
  "this won't"
end

# is equivalent to 

if true, do: "this will be seen", else: "this won't" 

# because if/2 is actually a function! fancy that! 
if(true, do: "aha!")

# -- nested data structures -- 

# often we will have maps inside maps, lists inside maps, maps inside lists, usf. Elixir 
# provides conveniences for manipulating nested data structures via the put_in/2, update_in/2 and other 
# macros giving the other conveniences you would find in imperative languages while keeping the 
# immutability of Elixir 

users = [
  john: %{
      name: "John Doe",
      age: 42,
      languages: ["Erlang", "Ruby", "Elixir"]
    }, 
  mary: %{
      name: "Mary Jane",
      age: 35,
      languages: ["Elixir", "F#", "Clojure"]
    }
]

# if we wanted to access John's age, we could do:
users[:john].age # => 42 

# we can use the same syntax to update his age 
put_in users[:john].age, 31 # => the updated map 

# this doesn't change the original map, but returns a new one, so we need to re-assign it
users = put_in users[:john].age, 31 

# the update_in/2 function is a bit more powerful than put_in/2, and allows you to specify a function to 
# handle how the data is updated 
update_in users[:mary].languages, fn languages ->
  List.delete(languages, "Clojure")
end 

# there's a lot more to unpack in the Kernel module, so check out the documentation
# -> https://hexdocs.pm/elixir/Kernel.html


