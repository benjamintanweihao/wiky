defmodule Wiky.Markov.Generator do
  alias Wiky.Markov.Dictionary

  def next(prefix) do
    Dictionary.get_suffixes(prefix) |> Enum.shuffle |> List.first
  end

  def generate_sentence(seed_prefix, max_length) when is_binary(seed_prefix) do
    generate_sentence([seed_prefix], 0, max_length)
  end

  def generate_sentence(result, max_length, max_length) do
    process_result(result)
  end

  def generate_sentence([prefix|rest] = list, current_length, max_length) do
    case next(prefix) do
      nil  ->
        process_result([prefix|rest])
      next ->
        generate_sentence([next|list], current_length+1, max_length)
    end
  end

  def process_result(result) do
    result |> Enum.reverse |> Enum.join(" ")
  end

end
