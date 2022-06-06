# due to Elixir's immutable data structures, we can't use recursion like in imperative languages

# in C, you'd use a loop to implement recursion:
#
# for (int i = 0; i < n; i++) {
#   printf("%d\n", i);
# }
#
# but that's not possible in Elixir due to the data of "i" not being mutable.
# Instead, we can use a function that takes uses default arguments and pattern matching to recursively call itself

defmodule DefaultArgAndClauses do
  def run_5_times(n \\ 5)

  def run_5_times(n) when n > 0 do
    IO.puts(n)
    run_5_times(n - 1)
  end

  def run_5_times(0), do: :ok
end

DefaultArgAndClauses.run_5_times()
#=>
# 5
# 4
# 3
# 2
# 1
# :ok

# let's see how we would sum a list of numbers using recursion
defmodule SumList do
  def sum_list([head | tail], accumulator) do
    sum_list(tail, head + accumulator)
  end

  def sum_list([], accumulator) do
    accumulator
  end
end

SumList.sum_list([1, 2, 3, 4, 5], 0) #=> 15

# this is known as a reduce algorithm in functional programming

# let's see how we'd double every element in a list using recursion
defmodule DoubleList do
  def double_list([head | tail]) do
    [head * 2 | double_list(tail)]
  end

  def double_list([]) do
    []
  end
end

DoubleList.double_list([1, 2, 3, 4, 5]) #=> [2, 4, 6, 8, 10]

# this is known as a map algorithm in functional programming

# as we can see there, recursion, when coupled with tools such as pattern
# matching, tail call optimisation and default arguments, can be a very powerful tool.

# by the way, the Enum module provides functions for mapping and reducing lists:
Enum.reduce([1, 2, 3], 0, &+/2) #=> 6 (using capture notation)
Enum.map([1, 2, 3], &(&1 * 2)) #=> [2, 4, 6]
