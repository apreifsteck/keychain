defmodule Keyring.Error do
  @type t :: %__MODULE__{}
  @enforce_keys [:reason]
  defstruct reason: nil
end
