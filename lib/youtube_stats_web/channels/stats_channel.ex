defmodule YoutubeStatsWeb.StatsChannel do
  use YoutubeStatsWeb, :channel

  def join("stats", _payload, socket) do
    send(self(), :after_join)
    {:ok, socket}
  end

  def handle_info(:after_join, socket) do
    push(socket, "war", YoutubeStats.War.last_stats())
    {:noreply, socket}
  end
end
