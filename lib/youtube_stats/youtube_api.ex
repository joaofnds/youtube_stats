defmodule YoutubeStats.YoutubeAPI do
  @key System.get_env("YOUTUBE_KEY")
  @base_query_params %{part: "statistics", key: @key}
  @channels_url "https://www.googleapis.com/youtube/v3/channels"

  def fetch_sub_count(username) do
    response =
      username
      |> build_url()
      |> HTTPoison.get()

    case response do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        body
        |> Poison.decode!()
        |> extract_sub_count()

      _ ->
        0
    end
  end

  defp build_url(username) do
    "#{@channels_url}?#{build_query(username)}"
  end

  defp build_query(username) do
    @base_query_params
    |> Enum.into(%{forUsername: username})
    |> URI.encode_query()
  end

  defp extract_sub_count(response_body) do
    case response_body do
      %{"items" => [%{"statistics" => %{"subscriberCount" => sub_count}}]} ->
        String.to_integer(sub_count)

      %{"items" => []} ->
        0
    end
  end
end
