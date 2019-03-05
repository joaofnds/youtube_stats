defmodule YoutubeStatsWeb.StatsChannelTest do
  use YoutubeStatsWeb.ChannelCase

  setup do
    {:ok, _, socket} =
      socket(YoutubeStatsWeb.UserSocket, "user_id", %{some: :assign})
      |> subscribe_and_join(YoutubeStatsWeb.StatsChannel, "stats")

    {:ok, socket: socket}
  end

  test "broadcasts are pushed to the client", %{socket: socket} do
    broadcast_from!(socket, "new-stats", %{"some" => "stat"})
    assert_push "new-stats", %{"some" => "stat"}
  end
end
