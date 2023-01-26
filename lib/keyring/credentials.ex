defmodule Keyring.Credentials do
  alias Keyring.Error

  defstruct backend: nil, credentials: []

  @typedoc """
  Struct has two keys:
  `backend`: a module that implements `Keyring.Backend`.
  `credentials`: `credentials()`
  """
  @type t :: %__MODULE__{}

  @typedoc """
  A keyword list of strings that should carry everything a backend needs to 
  know to generate parameters for its use case.
  """
  @type credentials :: keyword(String.t())
  @type api :: atom()

  @doc """
  Fetches the configuration of an API out of the application config.
  Will return an error tuple if the key cannot be found in the app config.
  """
  @spec fetch_for(api :: api()) :: {:ok, credentials()} | {:error, Error.t()}
  def fetch_for(api) do
    case Application.fetch_env(:keyring, api) do
      {:ok, _} = credentials ->
        credentials

      :error ->
        {:error, %Error{reason: :api_not_configured}}
    end
  end

  @doc """
  Creates a `%Credentials{}` struct from a configuration.
  Will return an error tuple if there is no backend specified in the options.
  Will return an error tuple if credential values are not all strings.
  """
  @spec build(opts :: keyword()) :: {:ok, t()} | {:error, Error.t()}

  def build(opts) do
    with {[backend: backend], credentials} <- Keyword.split(opts, [:backend]),
         true <- credentials |> Keyword.values() |> Enum.all?(&is_binary/1) do
      {:ok, %__MODULE__{backend: backend, credentials: credentials}}
    else
      _ ->
        {:error, %Error{reason: :misconfigured_api}}
    end
  end
end
