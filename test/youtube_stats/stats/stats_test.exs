defmodule YoutubeStats.StatsTest do
  use YoutubeStats.DataCase

  alias YoutubeStats.{Stats,Channels}
  alias YoutubeStats.Channels.Channel

  setup do
    {:ok, channel} = Repo.insert(%Channel{username: "name", channel_id: "id"})
    {:ok, channel: channel}
  end

  describe "stats" do
    alias YoutubeStats.Stats.Stat

    @valid_attrs %{sub_count: 42}
    @invalid_attrs %{sub_count: nil}

    def stat_fixture(channel \\ %Channel{}, attrs \\ %{}) do
      {:ok, stat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{channel_id: channel.id})
        |> Stats.create_stat()

      stat
        |> Repo.preload(:channel)
    end

    test "list_stats/0 returns all stats", %{channel: channel} do
      stat = stat_fixture(channel)
      assert Stats.list_stats() == [stat]
    end

    test "get_stat!/1 returns the stat with given id", %{channel: channel} do
      stat = stat_fixture(channel)
      assert Stats.get_stat!(stat.id) == stat
    end

    test "create_stat/1 with valid data creates a stat", %{channel: channel} do
      assert {:ok, %Stat{} = stat} =
        @valid_attrs
        |> Enum.into(%{channel_id: channel.id})
        |> Stats.create_stat()
      assert stat.sub_count == 42
    end

    test "create_stat/1 with invalid data returns error changeset", %{channel: channel} do
      assert {:error, %Ecto.Changeset{}} = Stats.create_stat(@invalid_attrs)
    end

    test "delete_stat/1 deletes the stat", %{channel: channel} do
      stat = stat_fixture(channel)
      assert {:ok, %Stat{}} = Stats.delete_stat(stat)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_stat!(stat.id) end
    end

    test "change_stat/1 returns a stat changeset", %{channel: channel} do
      stat = stat_fixture(channel)
      assert %Ecto.Changeset{} = Stats.change_stat(stat)
    end
  end
end
