defmodule YoutubeStats.Repo do
  use Ecto.Repo,
    otp_app: :youtube_stats,
    adapter: Ecto.Adapters.Postgres
end
