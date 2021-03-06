defmodule YoutubeStats.Stats.Stat do
  use Ecto.Schema
  import Ecto.Changeset

  alias YoutubeStats.Channels.Channel

  schema "stats" do
    field :sub_count, :integer
    belongs_to :channel, Channel

    timestamps()
  end

  @doc false
  def changeset(stat, attrs) do
    stat
    |> cast(attrs, [:channel_id, :sub_count])
    |> validate_required([:channel_id, :sub_count])
  end
end
