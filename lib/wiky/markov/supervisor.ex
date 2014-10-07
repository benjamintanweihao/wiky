defmodule Wiky.Markov.Supervisor do
  use Supervisor

  def start_link do
    Supervisor.start_link(__MODULE__, [])
  end
  
  def init([]) do
    pool_options = [
      name: {:local, :dictionary_worker_pool},
      worker_module: Wiky.Markov.Worker, 
      size: 5,
      max_overflow: 10
    ]

    children = [
      :poolboy.child_spec(:dictionary_worker_pool, pool_options, [])
    ]

    supervise(children, strategy: :one_for_one)
  end

end

