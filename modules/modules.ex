# in elixir, we group several functions together in modules, e.g.
# String.length/1 is in the String module.

# to declare modules, we use the defmodule macro 
defmodule MyModule do
  # we use the def macro to define functions in modules 
  def my_function(_arg) do
    # ...
  end 

  # we can also define private functions in modules
  defp my_private_function(_arg) do
    # ...  
  end

  # functions also support ! and ? in their names 
  def zero?(0) do # (arguments are pattern matched)
    true 
  end

  # they also support guards, which are expressions that must evaluate to true for the 
  # function to be called based on the arguments
  def zero?(x) when is_integer(x) do 
    false 
  end

  # ? is more commonly used as shorthand for is_... functions
  # whereas ! is used for functions which throw exceptions (like vim commands)

  # this function returns :ok or :error
  def check_file(file) when is_binary(file) do
    {res, _} = File.open(file)

    # return values like in Rust by having them at the end of the function
    res
  end

  # ! shows the user that this function throws an exception 
  def check_file!(file) when is_binary(file) do
    {res, contents} = File.open(file)

    case res do 
      :ok -> 
        nil 
      :error -> 
        raise("could not open file, #{inspect(res)}")
    end
  end

  # for more information see https://hexdocs.pm/elixir/main/naming-conventions.html#trailing-bang-foo 

  # we can also use keyword lists (see intro/keyword_lists_maps.exs) for functions 
  def one?(1), do: true 
  def one?(x) when is_integer(x), do: false
  # using those isn't recommended for multi-line functions, but it's OK for one-liners 

end

# if we compile this file with elixirc, we get a very nice new Elixir.MyModule.beam file
# which contains the compiled code for the module. this is automatically loaded by Elixir
# when it starts up (i.e. in iex and .exs files) 

# if we want to use the module, we can simply reference it by name in another file (or in the same 
# one if it's a .exs file):
# 
# MyModule.my_function(...)

# if we try to reference a private function, we get an error: 
#
# MyModule.my_private_function(...) => ** (UndefinedFunctionError)
