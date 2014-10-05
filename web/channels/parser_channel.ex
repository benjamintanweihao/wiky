defmodule Wiky.ParserChannel do
  use Phoenix.Channel

  def join(socket, "start-parser", message) do
    Wiky.Parser.start_link("/Users/benjamintan/Downloads/wiki.xml", &reply/3, socket)
    {:ok, socket}
  end

  def join(socket, _no, _message) do
    {:error, socket, :unauthorized}
  end

end

