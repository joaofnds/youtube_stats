defmodule YoutubeStats.War do
  alias YoutubeStats.{Channels, Stats, YoutubeAPI}

  def last_stats do
    pewds_stat = pewds_channel() |> Channels.get_last_stat
    tgay_stat = tgay_channel() |> Channels.get_last_stat
    war_stats(pewds_stat, tgay_stat)
  end

  def update_stats! do
    {:ok, pewds_stat} = pewds_channel() |> fetch_and_create_stat()
    {:ok, tgay_stat} = tgay_channel() |> fetch_and_create_stat()

    YoutubeStatsWeb.Endpoint.broadcast(
      "stats",
      "war",
      war_stats(pewds_stat, tgay_stat)
    )
  end

  defp war_stats(pewds_stat, tgay_stat) do
    %{
      pewds: pewds_stat.sub_count,
      tgay: tgay_stat.sub_count,
      gap: pewds_stat.sub_count - tgay_stat.sub_count
    }
  end

  defp fetch_and_create_stat(channel) do
    sub_count = YoutubeAPI.fetch_sub_count(channel.username)
    Stats.create_stat(%{sub_count: sub_count, channel_id: channel.id})
  end

  defp pewds_channel, do: Channels.get_channel!("pewdiepie")
  defp tgay_channel, do: Channels.get_channel!("tseries")
end
