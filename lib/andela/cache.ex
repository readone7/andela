defmodule Andela.Cache do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, %{}, name: AndelaCache)

  end
  def delete(key, data) do
    GenServer.cast(AndelaCache, {:delete, key, data})
  end

  def get(key) do
    GenServer.call(AndelaCache, {:get, key})
  end

  def put(key, data) do
    GenServer.cast(AndelaCache, {:put, key, data})
  end

  #internal API

  def init(state) do
    :ets.new(:user_cache, [:bag, :public, :named_table])
    {:ok, state}
  end


  def handle_cast({:put, key, data}, state) do
    :ets.insert(:user_cache, {key, data})
    {:noreply, state}
  end

  def handle_cast({:delete, key, data}, state) do
    :ets.delete_object(:user_cache, {key, data})
    {:noreply, state}
  end

  def handle_call({:get, key}, _from, state) do
    reply =
      case :ets.lookup(:user_cache, key) do
        [] -> nil
        [{_key, user}] -> user
        _ -> Keyword.values(:ets.lookup(:user_cache, key))
      end
    {:reply, reply, state}
  end
end
