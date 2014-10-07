defmodule Wiky.PageController do
  use Phoenix.Controller
  alias Poison, as: JSON

  plug :action

  def index(conn, _params) do
    render conn, "index"
  end

  def generate_sentence(conn, params) do
    sentence = params["seed_prefix"] |> Wiky.Markov.Generator.generate_sentence 100
    json conn, JSON.encode! %{result: sentence}
  end

  def not_found(conn, _params) do
    render conn, "not_found"
  end

  def error(conn, _params) do
    render conn, "error"
  end
end

