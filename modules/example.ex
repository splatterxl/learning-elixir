defmodule Math do
  @moduledoc """
  The Math module contains functions for basic mathematical operations.
  """
  @doc """
  Returns the sum of two integer or floating point numbers.
  """
  def sum(a, b) do 
    a + b
  end

  @doc """
  Returns the difference of two integer or floating point numbers.
  """
  def diff(a, b) do 
    a - b
  end

  @doc """
  Returns the product of two integer or floating point numbers.
  """
  def prod(a, b) do 
    a * b
  end 

  @doc """
  Returns the quotient of two integer or floating point numbers.
  """
  def quot(a, b) do 
    a / b
  end

  @doc """
  Returns the quotient of two integer or floating point numbers. 
  """
  def quot(a, b, [trunc: trunc]) do 
    if trunc do
      trunc(a / b)
    else
      a / b
    end
  end

  @doc """
  Returns the remainder of two integer or floating point numbers.
  """
  def rem(a, b) do 
    Kernel.rem(a, b)
  end
end
