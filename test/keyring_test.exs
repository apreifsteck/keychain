defmodule KeyringTest do
  use ExUnit.Case
  doctest Keyring

  alias Keyring.Credentials

  describe "params_for/1 - credentials" do
    test "returns a sane message when given empty credentials" do
      assert {:error, %Keyring.Error{reason: :backend_not_specified}} =
               Keyring.params_for(%Credentials{})
    end

    test "returns the params when the credentials are valid" do
      assert {:ok, []} =
               Keyring.params_for(%Credentials{backend: TestValidBackend, credentials: []})
    end

    test "returns an error if the backend invalidates the credentials" do
      assert {:error, %Keyring.Error{reason: :invalid_credentials}} =
               Keyring.params_for(%Credentials{backend: TestInvalidBackend})
    end
  end

  describe "params_for/1 - api" do
    test "returns a sane message when api is not configured" do
      assert {:error, %Keyring.Error{reason: :api_not_configured}} = Keyring.params_for(:foo)
    end

    test "returns the params when the api is configured" do
      assert {:ok, []} = Keyring.params_for(:test_api)
    end
  end
end
