defmodule Keyring do
  @moduledoc """
  Goals:
  1. Provide a way to authorize arbitrary HTTP requests
  3. Be flexible enough to provide a mechanism for any sort of auth scheme
  4. Be heavily configurable
  5. Be extensible
  6. Provide compile-time checks for config

  TODO:
  - Add doctests
  - Give every module a module doc
  - Add CI to the repo
  - Add a basica auth backend
  - rename whole app to keychain because this name is taken
  """
  @type params :: list({String.t(), String.t()})

  alias __MODULE__.Error
  alias __MODULE__.Credentials

  @spec params_for(api :: Credentials.api()) :: {:ok, params()} | {:error, Error.t()}
  def params_for(api)
      when is_atom(api) do
    with {:ok, credential_opts} <- Credentials.fetch_for(api),
         {:ok, credentials} <- Credentials.build(credential_opts) do
      params_for(credentials)
    end
  end

  @spec params_for(credentials :: Credentials.t()) :: {:ok, params()} | {:error, Error.t()}
  def params_for(%Credentials{backend: nil}) do
    {:error, %Error{reason: :backend_not_specified}}
  end

  def params_for(%Credentials{backend: backend, credentials: credentials}) do
    backend.params_for(credentials)
  end
end
