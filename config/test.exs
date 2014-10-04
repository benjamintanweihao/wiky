use Mix.Config

config :phoenix, Wiky.Router,
  port: System.get_env("PORT") || 4001,
  ssl: false,
  cookies: true,
  session_key: "_wiky_key",
  secret_key_base: "NXcNgN+V5KNPS+YIEchB/LfRqXUKrPWusD3rr13gGqM8LxiMYLi+QpVJqGvG1Z9dcZawSaN5OEIANU0CqYgGGg=="

config :phoenix, :code_reloader,
  enabled: true

config :logger, :console,
  level: :debug


