defmodule TestValidBackend do
  @behaviour Keyring.Backend

  @impl true
  def params_for(_credentials) do
    {:ok, []}
  end
end

defmodule TestInvalidBackend do
  @behaviour Keyring.Backend

  @impl true
  def params_for(_credentials) do
    {:error, %Keyring.Error{reason: :invalid_credentials}}
  end
end

ExUnit.start()

Application.put_env(:keyring, :test_api, key: "value", backend: TestValidBackend)
