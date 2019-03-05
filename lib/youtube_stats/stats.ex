defmodule YoutubeStats.Stats do
  @moduledoc """
  The Stats context.
  """

  import Ecto.Query, warn: false
  alias YoutubeStats.Repo

  alias YoutubeStats.Stats.Stat

  @doc """
  Returns the list of stats.

  ## Examples

      iex> list_stats()
      [%Stat{}, ...]

  """
  def list_stats do
    Stat
    |> Repo.all()
    |> Repo.preload(:channel)
  end

  @doc """
  Gets a single stat.

  Raises `Ecto.NoResultsError` if the Stat does not exist.

  ## Examples

      iex> get_stat!(123)
      %Stat{}

      iex> get_stat!(456)
      ** (Ecto.NoResultsError)

  """
  def get_stat!(id) do
    Stat
    |> Repo.get!(id)
    |> Repo.preload(:channel)
  end

  @doc """
  Creates a stat.

  ## Examples

      iex> create_stat(%{field: value})
      {:ok, %Stat{}}

      iex> create_stat(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_stat(attrs \\ %{}) do
    result =
      %Stat{}
      |> Stat.changeset(attrs)
      |> Repo.insert()

    case result do
      {:ok, stat} ->
        stat = Repo.preload(stat, :channel)

        YoutubeStatsWeb.Endpoint.broadcast(
          "stats",
          stat.channel.username,
          %{sub_count: stat.sub_count}
        )

        {:ok, stat}

      {:error, changeset} ->
        {:error, changeset}
    end
  end
end
