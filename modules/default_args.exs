# named functions also support default arguments

defmodule DefaultArgs do
  def foo(a, b \\ "bar") do
    a <> b
  end
end

# note that the default argument is not evaluated until the function is called
# but it can be any expression

DefaultArgs.foo("foo ") #=> "foo bar"
DefaultArgs.foo("foo ", "baz") #=> "foo baz"

# a function with multiple clauses must define a "head" clause
# that defines the arguments

defmodule MultipleClauses do
  def join(a, b \\ nil, sep \\ " ")

  def join(a, b, _sep) when is_nil(b) do
    a
  end

  def join(a, b, sep) do
    a <> sep <> b
  end
end

MultipleClauses.join("foo", "bar") #=> "foo bar"
MultipleClauses.join("foo", "bar", "baz") #=> "foobazbar"
MultipleClauses.join("foo") #=> "foo"
