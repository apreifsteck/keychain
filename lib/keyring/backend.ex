defmodule Keyring.Backend do
  alias Keyring.Credentials

  @doc """
  Transform a list of `Credentials.credentials()` 
  into `Keyring.params()`, according to the behiour of the 
  implementing module. May return an error if something goes wrong.
  """
  @callback params_for(credentials :: Credentials.credentials()) ::
              {:ok, Keyring.params()} | {:error, Keyring.Error.t()}
end
