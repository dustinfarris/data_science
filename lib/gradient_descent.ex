defmodule GradientDescent do
  def difference_quotient(f, x, h) do
    (f.(x + h) - f.(x)) / h
  end

  @doc """
  Return the i-th partial difference quotient of f at v.
  """
  def partial_difference_quotient(f, v, i, h) do
    w = List.update_at(v, i, & &1 + h)
    (f.(w) - f.(v)) / h
  end

  def estimate_gradient(f, v, h \\ 0.0001) do
    1..length(v)
    |> Enum.map(& partial_difference_quotient(f, v, &1, h))
  end

  @doc """
  Moves `step_size` in the `gradient` direction from `v`.
  """
  def gradient_step(v, gradient, step_size) when length(v) == length(gradient) do
    gradient
    |> LinearAlgebra.Vector.scalar_multiply(step_size)
    |> LinearAlgebra.Vector.add(v)
  end

  @doc """
  Determine the gradient based on the error from a single data point.
  """
  def linear_gradient(x, y, theta) do
    [slope, intercept] = theta
    predicted = slope * x + intercept  # the prediction of the model
    error = predicted - y  # error is (predicted - actual)
    _squared_error = :math.pow(error, 2)  # we want to minimize the squared error
    [2 * error * x, 2 * error]  # using its gradient
  end
end
