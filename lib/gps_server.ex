defmodule GpsServer do
  @moduledoc """
  GpsServer keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  @doc ~S"""
  Retrieves the last position.
  """

  def last_position() do
    GpsServer.Repo.last_position()
  end

  def create_position(params) do
    %GpsServer.Position{}
    |> GpsServer.Position.changeset(params)
    |> GpsServer.Repo.insert()
  end

  def last_path() do
    GpsServer.Repo.last_path()
  end
end
