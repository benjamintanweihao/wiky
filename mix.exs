defmodule Wiky.Mixfile do
  use Mix.Project

  def project do
    [ app: :wiky,
      version: "0.0.1",
      elixir: "~> 1.0.0",
      elixirc_paths: ["lib", "web"],
      deps: deps ]
  end

  # Configuration for the OTP application
  def application do
    [
      mod: { Wiky, [] },
      applications: [:phoenix, :cowboy, :logger]
    ]
  end

  # Returns the list of dependencies in the format:
  # { :foobar, git: "https://github.com/elixir-lang/foobar.git", tag: "0.1" }
  #
  # To specify particular versions, regardless of the tag, do:
  # { :barbat, "~> 0.1", github: "elixir-lang/barbat" }
  defp deps do
    [
      {:phoenix, github: "phoenixframework/phoenix"},
      {:cowboy, "~> 1.0.0"},
      {:erlsom, git: "git@github.com:willemdj/erlsom.git"},
      {:poolboy, github: "devinus/poolboy"}
    ]
  end
end
