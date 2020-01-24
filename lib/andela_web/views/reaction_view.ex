defmodule AndelaWeb.ReactionView do
  use AndelaWeb, :view

  def render("count.json", %{values: values}) do
    %{
      content_id: values["content_id"],
      reaction_count: values["reaction_count"]
    }
  end

  #def render("404.json") do

 # end
end
