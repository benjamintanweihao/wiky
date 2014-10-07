defmodule Wiky.Markov.Dictionary do

  def start_link do
    Agent.start_link(fn ->
      :random.seed(:os.timestamp)
      :ets.new(:dictionary, [:set, :named_table])
    end, name: __MODULE__, timeout: :infinity)
  end

  def get_suffixes(prefix) do
    Agent.get(__MODULE__, fn table_name ->
      case :ets.lookup(table_name, prefix) do
        [] -> []
        [{ ^prefix, suffixes }] -> suffixes
      end
    end)
  end

  def update_suffix(prefix, suffix_list) do
    Agent.update(__MODULE__, fn table_name ->
      :ets.insert(table_name, {prefix, suffix_list})
      table_name
    end)
  end

end

