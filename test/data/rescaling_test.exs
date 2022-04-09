defmodule RescalingTest do
  use ExUnit.Case

  import Data.Rescaling

  test "rescaling vectors" do
    vectors = [[-3, -1, 1], [-1, 0, 1], [1, 1, 1]]

    {means, stddevs} = scale(vectors)

    assert means == [-1.0, 0.0, 1.0]
    assert stddevs == [2, 1, 0]

    {means, stddevs} = vectors |> rescale() |> scale()

    assert means == [0, 0, 1]
    assert stddevs == [1, 1, 0]
  end
end
