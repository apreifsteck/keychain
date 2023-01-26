defmodule Keyring.Backends.Naive do
  @moduledoc """
  This backend just returns any keyword list it's given to
  `Keyring.params()`. 
  """

  @behaviour Keyring.Backend

  @impl true
  def params_for(credentials) do
    {:ok, Enum.map(credentials, fn {key, value} -> {Atom.to_string(key), value} end)}
  end
end
