use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :gps_server, GpsServerWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :gps_server, GpsServer.Repo,
  username: "postgres",
  password: "postgres",
  database: "gps_server_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
