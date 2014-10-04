use Mix.Config

# NOTE: To get SSL working, you will need to set:
#
#     ssl: true,
#     keyfile: System.get_env("SOME_APP_SSL_KEY_PATH"),
#     certfile: System.get_env("SOME_APP_SSL_CERT_PATH"),
#
# Where those two env variables point to a file on disk
# for the key and cert

config :phoenix, Wiky.Router,
  port: System.get_env("PORT"),
  ssl: false,
  host: "example.com",
  cookies: true,
  session_key: "_wiky_key",
  secret_key_base: "NXcNgN+V5KNPS+YIEchB/LfRqXUKrPWusD3rr13gGqM8LxiMYLi+QpVJqGvG1Z9dcZawSaN5OEIANU0CqYgGGg=="

config :logger, :console,
  level: :info,
  metadata: [:request_id]

