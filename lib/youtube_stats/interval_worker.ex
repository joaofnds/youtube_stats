defmodule YoutubeStats.IntervalWorker do
  def start_link([interval, function]) do
    Task.start_link(fn -> loop(interval, function) end)
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

  defp loop(interval, function) do
    receive do
      :stop -> :stopped
    after
      interval ->
        function.()
        loop(interval, function)
    end
  end
end
