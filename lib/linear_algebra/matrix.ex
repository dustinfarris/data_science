defmodule LinearAlgebra.Matrix do
  @doc """
  Compute the shape of a matrix.

      iex> shape([[1, 2, 3], [4, 5, 6]])
      {2, 3}
  """
  def shape(a) do
    if length(a) > 0 do
      {length(a), a |> Enum.at(0) |> length()}
    else
      {0, 0}
    end
  end

  @doc """
  Retrieve row `i` from matrix `a`.
  """
  def get_row(a, i) do
    Enum.at(a, i)
  end

  @doc """
  Retrieve column `j` from matrix `a`.
  """
  def get_column(a, j) do
    Enum.map(a, &Enum.at(&1, j))
  end

  @doc """
  Create a matrix given its shape and callback for generating elements.
  """
  def make_matrix(num_rows, num_cols, entry_fn) when num_rows > 0 and num_cols > 0 do
    1..num_rows
    |> Enum.map(fn i ->
      1..num_cols
      |> Enum.map(fn j ->
        entry_fn.(i, j)
      end)
    end)
  end

  @doc """
  Generate an identity matrix of size `n` x `n`.

      iex> identity_matrix(5)
      [
        [1, 0, 0, 0, 0],
        [0, 1, 0, 0, 0],
        [0, 0, 1, 0, 0],
        [0, 0, 0, 1, 0],
        [0, 0, 0, 0, 1]
      ]
  """
  def identity_matrix(n) do
    make_matrix(n, n, fn
      i, i -> 1
      _i, _j -> 0
    end)
  end
end
