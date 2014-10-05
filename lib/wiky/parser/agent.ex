defmodule Wiky.Parser.Agent do

  def start_link(reply_fn, socket) do
    Agent.start_link(fn -> %{progress_percentage: 0, progress_status: "not_started", reply_fn: reply_fn, socket: socket} end, name: __MODULE__) 
  end 

  def started? do
    get_progress_status == "started"
  end

  def not_started? do
    get_progress_status == "not_started"
  end

  def completed? do
    get_progress_status == "completed?"
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

  def update_progress_status(status) do
    Agent.update(__MODULE__, fn state ->
      %{state | progress_status: status}
    end)
  end

  def update_progress_percentage(percentage) do
    publish_progress
    Agent.update(__MODULE__, fn state ->
      %{state | progress_percentage: percentage}
    end)
  end

  def publish_progress do
    Agent.get(__MODULE__, fn state ->
      state.reply_fn.(state.socket, "progress", 
                      %{progress_percentage: state.progress_percentage,
                        progress_status: state.progress_status})
    end)
  end

end
