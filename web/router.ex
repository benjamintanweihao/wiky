defmodule Wiky.Router do
  use Phoenix.Router
  use Phoenix.Router.Socket, mount: "/ws"

  scope "/" do
    # Use the default browser stack.
    pipe_through :browser

    get "/", Wiky.PageController, :index, as: :pages
  end

  channel "wiky-parser-channel", Wiky.ParserChannel

end
