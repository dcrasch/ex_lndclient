defmodule ExLndclientTest do
  use ExUnit.Case
  doctest ExLndclient

  test "greets the world" do
    assert ExLndclient.hello() == :world
  end
end
