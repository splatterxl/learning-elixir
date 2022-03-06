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

# you can use the ? operator to get a character's code point
# THIS DOES NOT RESPECT VARIABLES, ONLY THE CHARACTER IN SOURCE
?a # => 97
97 = ?a 

# this is useful if you ever want to store the string in raw form
<<?a, ?b, ?c>> # raw form of "abc"

# that's a bitstring. it's a string of bits, and you can use it to store binary data
# it's denoted by the << and >> syntax and it's a contingous sequence of bits in memory.

# by default, it's a string of 8 bits, but you can change that with the :: modifier
true = <<42>> == <<42::8>> # => true
# one bit | two bits
<<0::1>> == <<2::2>> # => false

# the decimal number 3 is equivalent to the binary 0011 
<<0::1, 0::1, 1::1, 1::1>> == <<3::4>> # => true

# bits are also truncated, so you can't store a number larger than the bitsize
# this is useful for storing binary data, but it's not useful for storing integers
<<1>> === <<257>> # => true 

# since, 257 == 100000001, but the bitsize is only 8, the left-most bit is ignored 
# and the value gets truncated to just 00000001, which is 1 

# a binary is a bitstring where the number of bits is divisible by 8 
# this means that not every bitstring is a binary, and not every binary is a bitstring
# we can use is_binary/1 and is_bitstring/1 to demonstrate this 
a = <<3::4>> # not a binary 
false = is_binary a
true = is_bitstring a 

b = <<3::8>> # a binary 
true = is_binary b
true = is_bitstring b

# not every binary is a valid string 
String.valid?(<<239, 191, 19>>) # => false

# we can also pattern match in bitstrings, just like in tuples and lists 
<<0, 1, x>> = <<0, 1, 2>>
2 = x 
<<0, 1, ^x>> = <<0, 1, 2>> 

# unless we provide an explicit bitstring size, it's exactly one byte (8 bits), so if we want to match a 
# binary of an unknown size, we can use the binary modifier 
<<0, 1, x::binary>> = <<0, 1, 2, 3>>
<<2, 3>> = x

# there are also some other useful modifiers for pattern matching 
<<head::binary-size(2), tail::binary>> = <<0, 1, 2, 3>>
<<0, 1>> = head
<<2, 3>> = tail 

# the string concatenation operator is also useful for bitstrings 
"a" <> "ha" # => "aha"
<<0, 1>> <> <<2, 3>> # => <<0, 1, 2, 3>> 

# given that strings are just bitstrings, you can also pattern match them like that 
<<head, rest::binary>> = "banana" 
head == ?b # => true 
rest # => "anana"

# binary pattern matching only works on bytes, however, so we can't match a unicode char first 
"ü" <> <<0>> # => <<195, 188, 0>> 
<<x, rest::binary>> = "über"
x == ?u # => false 
rest # => <<188, 98, 101, 114>>

# elixir has a special modifier for matching unicode characters
<<x::utf8, rest::binary>> = "über"
x == ?ü # => true 
rest # => <<98, 101, 114>>; "ber" 

# elixir has excellent support for strings, as you can see. 

# a charlist is a list of valid code points, and can be used to store strings
# whereas strings (binaries) are denoted by "", charlists are created with single quotes 
'hello' = [?h, ?e, ?l, ?l, ?o] 

# you won't really see this often, except when you're interfacing directly with erlang or using an old library
# that doesn't support binaries.

# in IEx, any list that has valid ASCII code points (0..127) will be converted to a string to print, which can lead to 
# unexpected results 
heartbeats_per_minute = [99, 97, 116]

# you won't guess what this prints 

inspect(heartbeats_per_minute) # => 'cat'

# you can convert charlists (and other values) to strings using to_string/1 
to_string(heartbeats_per_minute) # => "cat"
to_charlist("hełło") # => [104, 101, 322, 322, 111]

# to_string/1 is polymorphic, so it can be used on any value
to_string(:atom) # => "atom"
to_string(1) # => "1"

# to concatenate charlists, use the ++ operator
'hello' ++ ' ' ++ [?w, ?o, ?r, ?l, ?d] # => "hello world"

