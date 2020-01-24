  defmodule AndelaWeb.ReactionController do
    use AndelaWeb, :controller
    alias Andela.Cache

    def create(_conn, %{"type" => "reaction","action" => "add", "content_id"=>content_id, "user_id"=>user_id, "reaction_type"=>"fire"}) do
      content = content_id
      user = user_id
      Cache.put(content, user)
    end
    def create(_conn, %{"type" => "reaction","action" => "remove", "content_id"=>content_id}) do
      content = content_id
      Cache.delete(content)
    end

    def count(conn, %{"content_id" => content_id}) do
      content = content_id
      if Cache.get(content) == nil do
        render(conn, AndelaWeb.ErrorView, "400.json")
      else
        user = Cache.get(content)
        unique_users = Enum.uniq(user)
        reaction_count = %{"fire"=>Enum.count(unique_users)}
        values = %{
          "content_id"=> content_id,
          "reaction_count"=> reaction_count
        }
        render(conn, "count.json", values: values)
      end
    end
  end
