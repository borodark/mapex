defmodule Mapex.Repo do
  use Ecto.Repo,
    otp_app: :sfofoods,
    adapter: Ecto.Adapters.SQLite3
end
