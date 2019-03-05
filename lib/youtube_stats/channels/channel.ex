defmodule YoutubeStats.Channels.Channel do
  use Ecto.Schema
  import Ecto.Changeset


  schema "channels" do
    field :channel_id, :string
    field :username, :string

    timestamps()
  end

  @doc false
  def changeset(channel, attrs) do
    channel
    |> cast(attrs, [:channel_id, :username])
    |> validate_required([:channel_id, :username])
  end
end
