defmodule Data.Rescaling do
  alias LinearAlgebra.Vector

  @doc """
  Return the mean and standard deviation for each position.
  """
  def scale(data) do
    dim = data |> Enum.at(0) |> length()

    means = Vector.mean(data)

    stddevs =
      0..(dim - 1)
      |> Enum.map(fn i ->
        data
        |> Enum.map(fn row -> Enum.at(row, i) end)
        |> Statistics.standard_deviation()
      end)

    {means, stddevs}
  end

  @doc """
  Rescales the input data so that each position has
  mean 0 and standard deviation 1.

  Leaves a position as is if its standard deviation is 0.
  """
  def rescale(data) do
    {means, stddevs} = scale(data)

    data
    |> Enum.map(fn v ->
      [v, means, stddevs]
      |> Enum.zip()
      |> Enum.map(fn
        {d, mean, stddev} when stddev > 0 ->
          (d - mean) / stddev

        {d, _mean, _stddev} ->
          # stddevs is <= 0, returning d
          d
      end)
    end)
  end
end
