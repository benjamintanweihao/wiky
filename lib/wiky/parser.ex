defmodule Wiky.Parser do
  alias Wiky.Parser.State
  alias Wiky.Parser.ProgressState

  @chunk 1000000

  def start_link(path) do
    case ProgressState.start_link do
      {:ok, _pid} ->
        spawn_link(fn -> run(path) end)
      {:error, {:already_started, _pid}} ->
        if ProgressState.not_started?, do: spawn_link(fn -> run(path) end)
      _ ->
        IO.puts "Something horrible happened!"
    end
  end

  def run(path) do
    {:ok, handle}      = File.open(path, [:binary])
    file_size_in_bytes = File.stat!(path).size

    position           = 0
    c_state            = {handle, position, file_size_in_bytes, @chunk}
    sax_callback_state = nil

    ProgressState.update_progress_status("started")

    :erlsom.parse_sax("", 
                      sax_callback_state, 
                      &sax_event_handler/2, 
                      parser_options(&continue_file/2, c_state))

    :ok = File.close(handle)
  end

  def continue_file(tail, {handle, offset, file_size_in_bytes, chunk}) do
    case :file.pread(handle, offset, chunk) do
      {:ok, data} ->
        read_bytes = offset + chunk

        ProgressState.update_progress_percentage(read_bytes/file_size_in_bytes * 100)
        ProgressState.broadcast_progress

        {<<tail :: binary, data::binary>>, {handle, read_bytes, file_size_in_bytes, chunk}}
      :oef ->

        ProgressState.update_progress_percentage(100)
        ProgressState.update_progress_status("completed")
        ProgressState.broadcast_progress

        {tail, {handle, offset, chunk}}
    end
  end

  def sax_event_handler({:startElement, _, 'title', _, _}, _state) do
    %State{}
  end

  def sax_event_handler({:startElement, _, 'text', _, _}, state) do
    %{state | element_acc: ""}
  end

  def sax_event_handler({:characters, value}, %State{element_acc: element_acc} = state) do
    %{state | element_acc: element_acc <> to_string(value)}
  end

  def sax_event_handler({:endElement, _, 'title', _}, state) do
    %{state | title: state.element_acc}
  end

  def sax_event_handler({:endElement, _, 'text', _}, state) do
    %{state | text: state.element_acc}
  end

  def sax_event_handler(:endDocument, state), do: state
  def sax_event_handler(_, state), do: state

  defp parser_options(continuation_fn, c_state) do
    [{:continuation_function,     continuation_fn, c_state},
      {:max_entity_depth,         :infinity},
      {:max_entity_size,          :infinity},
      {:max_nr_of_entities,       :infinity},
      {:max_expanded_entity_size, :infinity}]
  end

end

