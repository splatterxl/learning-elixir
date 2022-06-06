# you may have noticed that we use <function>/<arity> to identify functions.
# well, this is because we can actually capture the function value using this.

&rem/2; # => &:erlang.rem/2, a reference to the function 

# it's treated as an anonymous function, so you must use a dot to access the function
func = &rem/2;

func.(3, 2); # => 1

# you can also use it as shorthand for creating a function 

hello = &("Hello, #{&1}!")

IO.puts(hello.("world")); # => Hello, world!
