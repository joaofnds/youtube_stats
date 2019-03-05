defmodule YoutubeStatsWeb.StatsChannel do
  use YoutubeStatsWeb, :channel

  def join("stats", _payload, socket) do
    {:ok, socket}
  end
end
