defmodule IndexListener.Mixfile do
  use Mix.Project

  def project do
    [app: :index_listener,
     version: "0.1.0",
     elixir: "~> 1.4-dev",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps()]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    #[applications: [:logger, :httpoison, :floki, :postgrex, :ecto],
    [applications: [:logger, :httpoison, :floki, :redix],
     mod: {IndexListener, []}]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type "mix help deps" for more examples and options
  defp deps do
    [
      {:httpoison, "~> 0.9.0"},
      {:floki, "~> 0.10.0"},
      {:redix, ">= 0.0.0"}
      #{ :exredis, github: "artemeff/exredis", tag: "0.2.4" },
      #{ :postgrex, ">= 0.6.0" },
      #{ :ecto, "~> 2.0.1" }
    ]
  end
end
