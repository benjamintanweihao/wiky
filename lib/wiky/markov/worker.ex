defmodule Wiky.Markov.Worker do
  use GenServer

  alias Wiky.Markov.Dictionary

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, [])
  end

  def run(pid, text) do
    GenServer.call(pid, {:run, text})
  end

  def handle_call({:run, text}, _from, state) do
    {:reply, build_dictionary(text), state}
  end

  def build_dictionary(text) when is_binary(text) do
    tokens = String.split(text)
    build_dictionary(tokens)
  end

  def build_dictionary([prefix, suffix|rest]) do
    if word?(suffix) do
      case Dictionary.get_suffixes(prefix) do
        nil ->
          Dictionary.update_suffix(prefix, [suffix])
        suffixes ->
          Dictionary.update_suffix(prefix, [suffix|suffixes])
      end
      build_dictionary([suffix|rest])
    else
      build_dictionary(rest)
    end
  end

  def build_dictionary(_source) do
    :ok
  end

  def word?(word) do
    Regex.match? ~r/^[a-zA-Z]+$/, word
  end


end

