defmodule YoutubeStats.Repo.Migrations.CreateChannels do
  use Ecto.Migration

  def change do
    create table(:channels) do
      add :channel_id, :string
      add :username, :string

      timestamps()
    end
  end
end
