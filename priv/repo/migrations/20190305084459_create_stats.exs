defmodule YoutubeStats.Repo.Migrations.CreateStats do
  use Ecto.Migration

  def change do
    create table(:stats) do
      add :sub_count, :integer
      add :channel_id, references(:channels, on_delete: :delete_all), null: false

      timestamps()
    end

    create index(:stats, [:channel_id])
  end
end
