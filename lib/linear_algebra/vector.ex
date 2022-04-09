defmodule LinearAlgebra.Vector do
  @moduledoc """
  Functions to support linear algebra.
  """

  @doc ~S"""
  Add corresponding elements in two vectors.

      iex> add([1, 2, 3], [4, 5, 6])
      [5, 7, 9]
  """
  def add(v, w) when is_list(v) and is_list(w) and length(v) == length(w) do
    [v, w]
    |> Enum.zip()
    |> Enum.map(fn {v_i, w_i} -> v_i + w_i end)
  end

  @doc ~S"""
  Subtract corresponding elements in two vectors.

      iex> subtract([5, 7, 9], [4, 5, 6])
      [1, 2, 3]
  """
  def subtract(v, w) when is_list(v) and is_list(w) and length(v) == length(w) do
    [v, w]
    |> Enum.zip()
    |> Enum.map(fn {v_i, w_i} -> v_i - w_i end)
  end

  @doc """
  Component-wise sum a list of vectors.

  Create a new vector whose first element is the sum of all the first
  elements, whose second element is the sum of all the second elements,
  and so on.

      iex> sum([[1, 2], [3, 4], [5, 6], [7, 8]])
      [16, 20]
  """
  def sum(vectors) do
    Enum.zip_with(vectors, &Enum.sum/1)
  end

  @doc """
  Multiply a vector by a scalar.

    iex> scalar_multiply([1, 2, 3], 2.0)
    [2.0, 4.0, 6.0]
  """
  def scalar_multiply(v, c) when is_float(c) and is_list(v) do
    Enum.map(v, fn v_i -> c * v_i end)
  end

  @doc """
  Compute the component-wise means of a list of vectors.

    iex> mean([[1, 2], [3, 4], [5, 6]])
    [3.0, 4.0]
  """
  def mean(vectors) do
    vectors
    |> sum()
    |> scalar_multiply(1 / length(vectors))
  end

  @doc """
  Compute the sum of two vectors' component-wise products.

      iex> dot([1, 2, 3], [4, 5, 6])
      32
  """
  def dot(v, w) when is_list(v) and is_list(w) and length(v) == length(w) do
    [v, w]
    |> Enum.zip()
    |> Enum.map(fn {v_i, w_i} -> v_i * w_i end)
    |> Enum.sum()
  end

  @doc """
  Compute a vector's sum of squares.

      iex> sum_of_squares([1, 2, 3])
      14
  """
  def sum_of_squares(v) when is_list(v) do
    dot(v, v)
  end

  @doc """
  Compute a vector's magnitude (or length).

      iex> magnitude([3, 4])
      5.0
  """
  def magnitude(v) when is_list(v) do
    v
    |> sum_of_squares()
    |> :math.sqrt()
  end

  @doc """
  Compute the squared distance between two vectors.
  """
  def squared_distance(v, w) when is_list(v) and is_list(w) do
    v
    |> subtract(w)
    |> sum_of_squares()
  end

  @doc """
  Compute the distance between two vectors.
  """
  def distance(v, w) when is_list(v) and is_list(w) do
    v
    |> subtract(w)
    |> magnitude()
  end
end
