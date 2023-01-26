defmodule Keyring.CredentialsTest do
  use ExUnit.Case

  alias Keyring.Credentials

  describe "fetch_for/1" do
    test "Returns an error when the api cannot be found" do
      assert {:error, %Keyring.Error{reason: :api_not_configured}} = Credentials.fetch_for(:foo)
    end

    test "Returns a keyword list when the API is configured" do
      assert {:ok, list} = Credentials.fetch_for(:test_api)
      assert Keyword.keyword?(list)
    end
  end

  describe "build/1" do
    test "extracts backend from credentials" do
      assert {:ok, %Credentials{backend: :foo, credentials: [key: "value"]}} =
               Credentials.build(backend: :foo, key: "value")
    end

    test "errors if there is no backend in credentials" do
      assert {:error, %Keyring.Error{reason: :misconfigured_api}} =
               Credentials.build(key: "value")
    end

    test "errors if keyword values are not strings" do
      assert {:error, %Keyring.Error{reason: :misconfigured_api}} = Credentials.build(key: :value)
    end
  end
end
