defmodule Keyring.Backends.NaiveTest do
  use ExUnit.Case
  alias Keyring.Backends.Naive

  describe "params_for/1" do
    test "returns stringified params" do
      assert {:ok, [{"key", "value"}, {"OtherKey", "other value"}]} =
               Naive.params_for(key: "value", OtherKey: "other value")
    end
  end
end
