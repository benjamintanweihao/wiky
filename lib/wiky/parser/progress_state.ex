defmodule Wiky.Parser.ProgressState do

  def start_link do
    Agent.start_link(fn -> %{progress_percentage: 0, progress_status: "not_started"} end, name: __MODULE__) 
  end 

  def started? do
    get_progress_status == "started"
  end

  def not_started? do
    get_progress_status == "not_started"
  end

  def completed? do
    get_progress_status == "completed"
  end

  def get_state do
    Agent.get(__MODULE__, fn state ->
      state
    end) 
  end

  def get_progress_status do
    Agent.get(__MODULE__, fn state ->
      state.progress_status
    end) 
  end

  def get_progress_percentage do
    Agent.get(__MODULE__, fn state ->
      state.progress_percentage
    end)
  end

  def update_progress(status, percentage) do
    Agent.update(__MODULE__, fn state ->
      state = %{state | progress_status: status}
      %{state | progress_percentage: percentage}
    end)
  end

  def broadcast_progress do
    Agent.get(__MODULE__, fn state ->
      Phoenix.Channel.broadcast("wiky-parser-channel", "start-parser", "progress", state)
    end)
  end

end
