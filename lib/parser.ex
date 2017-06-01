defmodule Parser do

  def get_listings(body) do
    Floki.find(body, "a.hdrlnk") |>
    Floki.attribute("href") |>
    Enum.map(&("http://boston.craigslist.org" <> &1))
  end

  def get_postids(body) do
    Floki.find(body, "a.hdrlnk") |>
    Floki.attribute("data-id")
  end

  def get_neighborhood(tuple) do
    {"span", _, name} = tuple
    name
  end

  defp get_neighborhood_tuples(body) do
    Floki.find(body, "#titletextonly")
  end

  def get_neighborhoods(body) do
    nlist = get_neighborhood_tuples(body)
    List.foldr(nlist, [], fn(x, acc) -> get_neighborhood(x) ++ acc end)
  end

  # Returns map where postid is the key to a {listing_url, neighborhood} tuple
  # %{"5705455928" => {"http://boston.craigslist.org/gbs/fee/5705455928.html",
  #  "Just Renovated Great One Bed with Office Move in Flexible 8/1-9/1"},
  # "5703502907" => {"http://boston.craigslist.org/gbs/fee/5703502907.html",
   # "Mission Hill Studio--Av 9/1--Near Longwood Medical Area"},
  def get_index_page_map(body) do
    nlist = Parser.get_neighborhoods(body)
    postids = Parser.get_postids(body)
    listings = Parser.get_listings(body)

    Enum.zip(postids, Enum.zip(listings, nlist)) |>
    Enum.into(%{})
  end

end
