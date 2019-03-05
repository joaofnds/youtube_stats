defmodule YoutubeStats.Channels.Channel do
  use Ecto.Schema
  import Ecto.Changeset

  alias YoutubeStats.Stats.Stats

  schema "channels" do
    field :channel_id, :string
    field :username, :string
    has_many :stats, Stat

    timestamps()
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:channel_id, :username])
    |> validate_required([:channel_id, :username])
    |> unique_constraint(:username)
    |> unique_constraint(:channel_id)
  end
end
