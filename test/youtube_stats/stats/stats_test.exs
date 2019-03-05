defmodule YoutubeStats.StatsTest do
  use YoutubeStats.DataCase

  alias YoutubeStats.Stats

  describe "stats" do
    alias YoutubeStats.Stats.Stat

    @valid_attrs %{sub_count: 42}
    @update_attrs %{sub_count: 43}
    @invalid_attrs %{sub_count: nil}

    def stat_fixture(attrs \\ %{}) do
      {:ok, stat} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Stats.create_stat()

      stat
    end

    test "list_stats/0 returns all stats" do
      stat = stat_fixture()
      assert Stats.list_stats() == [stat]
    end

    test "get_stat!/1 returns the stat with given id" do
      stat = stat_fixture()
      assert Stats.get_stat!(stat.id) == stat
    end

    test "create_stat/1 with valid data creates a stat" do
      assert {:ok, %Stat{} = stat} = Stats.create_stat(@valid_attrs)
      assert stat.sub_count == 42
    end

    test "create_stat/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stats.create_stat(@invalid_attrs)
    end

    test "update_stat/2 with valid data updates the stat" do
      stat = stat_fixture()
      assert {:ok, %Stat{} = stat} = Stats.update_stat(stat, @update_attrs)
      assert stat.sub_count == 43
    end

    test "update_stat/2 with invalid data returns error changeset" do
      stat = stat_fixture()
      assert {:error, %Ecto.Changeset{}} = Stats.update_stat(stat, @invalid_attrs)
      assert stat == Stats.get_stat!(stat.id)
    end

    test "delete_stat/1 deletes the stat" do
      stat = stat_fixture()
      assert {:ok, %Stat{}} = Stats.delete_stat(stat)
      assert_raise Ecto.NoResultsError, fn -> Stats.get_stat!(stat.id) end
    end

    test "change_stat/1 returns a stat changeset" do
      stat = stat_fixture()
      assert %Ecto.Changeset{} = Stats.change_stat(stat)
    end
  end
end
