defmodule Probability do
  # Uniform distribution

  def uniform_pdf(x) when is_float(x) do
    if 0 <= x and x < 1 do
      1
    else
      0
    end
  end

  def uniform_cdf(x) when is_float(x) do
    cond do
      x < 0 -> 0
      x < 1 -> x
      true -> 1
    end
  end

  # Normal distribution

  def normal_pdf(x, mu, sigma) when is_float(x) and is_float(mu) and is_float(sigma) do
    :math.exp(-(:math.pow((x-mu)/sigma, 2)) / 2) / (:math.sqrt(2 * :math.pi) * sigma)
  end

  def normal_cdf(x, mu, sigma) when is_float(x) and is_float(mu) and is_float(sigma) do
    (1 + :math.erf((x-mu) / :math.sqrt(2) / sigma)) / 2
  end

  @doc """
  Find approximate inverse using binary search.

  When you know the probability and want to know what value would have that probability.
  """
  def inverse_normal_cdf(p, mu, sigma, tolerance \\ 0.00001)

  def inverse_normal_cdf(p, 0.0, 1.0, tolerance) when is_float(p) do
    low_z = -10.0
    hi_z = 10.0

    bisect(p, hi_z, low_z, tolerance)
  end

  def inverse_normal_cdf(p, mu, sigma, tolerance) do
    # if not standard, compute standard and rescale
    mu + sigma * inverse_normal_cdf(p, 0.0, 1.0, tolerance)
  end

  defp bisect(_p, hi_z, low_z, tolerance) when hi_z - low_z <= tolerance do
    (low_z + hi_z) / 2
  end

  defp bisect(p, hi_z, low_z, tolerance) do
    mid_z = (low_z + hi_z) / 2
    mid_p = normal_cdf(mid_z, 0.0, 1.0)

    if mid_p < p do
      bisect(p, hi_z, mid_z, tolerance)
    else
      bisect(p, mid_z, low_z, tolerance)
    end
  end
end
