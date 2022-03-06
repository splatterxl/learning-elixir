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

