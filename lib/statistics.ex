defmodule Statistics do
  @doc """
  Compute the mean (or average).

      iex> mean([1, 2, 3, 4, 5])
      3.0
  """
  def mean(xs) when is_list(xs) do
    Enum.sum(xs) / length(xs)
  end

  @doc """
  Compute the median.

    iex> median([1, 10, 2, 9, 5])
    5

    iex> median([1, 9, 2, 10])
    (2 + 9) / 2
  """
  def median(xs) when is_list(xs) do
    if rem(length(xs), 2) == 0 do
      median_even(xs)
    else
      median_odd(xs)
    end
  end

  defp median_odd(xs) do
    midpoint = xs |> length() |> div(2)

    xs
    |> Enum.sort()
    |> Enum.at(midpoint)
  end

  defp median_even(xs) do
    hi_midpoint = xs |> length() |> div(2)

    hi = xs |> Enum.sort() |> Enum.at(hi_midpoint)
    low = xs |> Enum.sort() |> Enum.at(hi_midpoint - 1)

    mean([hi, low])
  end

  @doc """
  Compute the `p`th-percentil value in `xs`.

      iex> quantile([1, 2, 3, 4, 5], 0.20)
      2
  """
  def quantile(xs, p) when is_list(xs) and is_float(p) do
    p_index = trunc(p * length(xs))

    xs
    |> Enum.sort()
    |> Enum.at(p_index)
  end

  @doc """
  Compute the mode.

      iex> mode([1, 1, 2, 2, 2, 3, 4, 5])
      2
  """
  def mode(xs) when is_list(xs) do
    xs
    |> Enum.frequencies()
    |> Enum.max_by(fn {_value, count} -> count end)
    |> elem(0)
  end

  @doc """
  Compute the range.

      iex> range([1, 3, 5, 7])
      6
  """
  def range(xs) when is_list(xs) do
    Enum.max(xs) - Enum.min(xs)
  end

  @doc """
  Translate xs by subtracting its mean (so that the result has mean 0).

      iex> de_mean([1, 2, 3, 4, 5])
      [-2.0, -1.0, 0.0, 1.0, 2.0]
  """
  def de_mean(xs) when is_list(xs) do
    x_bar = mean(xs)

    Enum.map(xs, fn x -> x - x_bar end)
  end

  @doc """
  Almost the average squared deviation from the mean.

      iex> variance([1, 2, 3, 4, 5])
      2.5
  """
  def variance(xs) when is_list(xs) and length(xs) >= 2 do
    deviations = de_mean(xs)

    LinearAlgebra.Vector.sum_of_squares(deviations) / (length(xs) - 1)
  end

  @doc """
  Compute the standard deviation by taking the square root of the variance.

      iex> standard_deviation([1, 2, 3, 4, 5])
      :math.sqrt(2.5)
  """
  def standard_deviation(xs) when is_list(xs) do
    xs |> variance() |> :math.sqrt()
  end

  @doc """
  Compute how two variables vary in tandem from their means.
  """
  def covariance(xs, ys) when is_list(xs) and is_list(ys) and length(xs) == length(ys) do
    LinearAlgebra.Vector.dot(de_mean(xs), de_mean(ys)) / (length(xs) - 1)
  end

  @doc """
  Compute how two variables vary in tandem around their means.
  """
  def correlation(xs, ys) when is_list(xs) and is_list(ys) and length(xs) == length(ys) do
    stdev_x = standard_deviation(xs)
    stdev_y = standard_deviation(ys)

    if stdev_x > 0 and stdev_y > 0 do
      covariance(xs, ys) / stdev_x / stdev_y
    else
      0
    end
  end
end
