x = 2
y = 3

# this is pattern matching
5 = x + y
1 = y - x 

# division operator always returns a float 
2.0 = 10 / 5 

# most common arithmetic operators work as expected 
if x + y != 5 or y - x != 1 or x * y != 6 or 10 / 5 != 2.0 do
    raise("Arithmetic operators do not work as expected")
end


# pattern matching is basically shorthand for checking if something is something else
true = is_float(10 / 5) # (it'd raise an exception if it wasn't)

x = 1 
{a, b, c} = {1, 2, 3}
# a, b and c are now the tuple's values, respectively,
# a bit like object destructuring in JS 

IO.puts("#{a} #{b} #{c}")

# we can also check if a tuple's value is equal to something without setting the variable 
^x = 1 # if x wasn't 1, it would error, otherwise it would just continue without touching x
x = 2 # this sets x to 2, even if x isn't already 2 

# this is useful for error handling 
{:error, err} = File.open("file.txt") # this checks if the file doesn't exist 
# we can then throw the error or just print it 
IO.puts(err); # this will always print :enoent in our case, since file.txt doesn't exist

# (in the case of an error, the second tuple value is an atom of the error message)

# strings are unicode, and can have newlines 
str = "Hellö,
"

# + operator doesn't work with strings, so we need to use <>
str <> "World!"

# get the chars of a string 
graphemes = str |> String.graphemes()

# there are a lot of useful methods for checking types of stuff 
if not is_list(graphemes) do 
  raise("String.graphemes() is not a list")
end

# case statements are like switch statements in JS, only using elixir patterns
case x do
  1 ->
    IO.puts("x is 1")
  2 ->
    IO.puts("x is 2")
  # you can use guard statements to set to a value only if the guard succeeds 
  x when x > 0 -> 
    IO.puts("x is positive: #{x}")
  _ -> # _ means to drop the value, so we can use it for default; if we wanted to 
       # use the value we might write "val ->"
    IO.puts("x is neither 1 nor 2")
end

# you can also get the return value of the effective statement

x = case 1 do
  1 -> :ok
  2 -> :error
end

# x will now be :ok
:ok = x

# atoms are variables whose values are their own name
a = :a
b = :b 

if a == :a and b != :a do
  IO.puts("a is an atom with a value equal to its name")
end

# they are useful for error handling 
do_stuff = fn -> :ok end 

case do_stuff.() do
  :ok ->
    IO.puts("do_stuff() returned :ok")
  :error ->
    raise("do_stuff() returned :error")
end

# elixir allows you to drop the : before certain atom names for simplicity, like true, false and nil

:nil = nil # => true

# lists in elixir are linked lists, so they can be slow at times 
# (but they are fast enough for most things)
list = [1, 2, 3]

# you can get the length of a list 
# (for nerds, this is in linear time because it's a linked list)
_ = length list 

# unfortunately, you can't get a specific element

# ++ adds two lists together
_ = list ++ [4] # => [1, 2, 3, 4]

# -- removes the elements of the second list from the first 
_ = [1, 2, 3] -- [2, 3] # => [1]  

# they can be of multiple types 
[1, 2, 3, "hello"] 

# and can be nested
[1, [2, 3], [4, [5, 6]]]

# tuples, on the other hand are faster than lists 
# they can also hold different types as well 
tuple = {1, 2, 3, "hello"}

# get a specific element (starting at 0)
_ = elem(tuple, 1) # => 2 

# get the size of the tuple 
_ = tuple_size tuple # => 4

# it's worth noting that tuple_size/1 is usually much faster than length/1
# since linked lists are linear and we have to traverse through the entire list 
# to get its length, but in tuples we don't 

# anonymous functions are defined with the fn keyword
# they can be called through .() and CAN'T BE CALLED WITHOUT PARENTHESES
add = fn a, b -> a + b end

3 = add.(1, 2)

# non-anonymous functions can be called without parentheses, but they can't be called with .()
3 = length([1, 2, 3])
3 = length [1, 2, 3]
# since length/1 is not an anonymous function, it can't be called with .()

