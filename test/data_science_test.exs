defmodule DataScienceTest do
  use ExUnit.Case
  doctest DataScience

  test "greets the world" do
    assert DataScience.hello() == :world
  end
end
