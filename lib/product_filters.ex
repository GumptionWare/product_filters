defmodule ProductFilters do
    @moduledoc """
    Documentation for `ProductFilters`
    """

    @doc """
    Filter products by name, category, and price.

    ## Examples

    Filter by name

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], name: "Laptop")
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], name: "apt")
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], name: "APT")
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], name: "Phone")
    []

    Filter by category

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], category: :tech)
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], category: :health)
    []

    Filter by min price.

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], min: 100)
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], min: 50)
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], min: 200)
    []

    Filter by max price.

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], max: 100)
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], max: 200)
    [%{name: "Laptop", category: :tech, price: 100}]

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], max: 50)
    []

    Multiple filters.

    iex> ProductFilters.filter([%{name: "Laptop", category: :tech, price: 100}], min: 50, max: 200, name: "Laptop", category: :tech)
    """
    # TO DO: Refactor this to NinjaLand
    def filter(products, filters \\ nil) # Idiomatic way of declaring default value
    # The "more correct" default (above) would be an empty list [].

    # Deal with the JON doctrine (no filters):
    def filter(products, filters) when is_nil(filters), do: products

    def filter(products, [{key, value}]) when key == :category do
      Enum.filter(products, fn item ->
        item.category == value
      end)
    end

    def filter(products, [{key1, value}, {key2, value}]) do
      if Keyword.has_key?([{key1, value}, {key2, value}], :min)
        and Keyword.has_key?([{key1, value}, {key2, value}], :max) do
        Enum.filter(products, fn item ->
          item.price >= Keyword.get([{key1, value}, {key2, value}], :min)
            and item.price <= Keyword.get([{key1, value}, {key2, value}], :max)
        end)
      end
    end

    def filter(products, [{key, value}]) when key == :min do
      Enum.filter(products, fn item ->
        item.price >= value
      end)
    end

    def filter(products, [{key, value}]) when key == :max do
      Enum.filter(products, fn item ->
        item.price <= value
      end)
    end

    def filter(products, [{_key, value}]) do
      Enum.filter(products, fn item ->
        String.contains?(String.upcase(item.name), String.upcase(value))
      end)
    end

    def filter(products, [h_filter | t_filters]) do
      IO.inspect(h_filter)
      IO.inspect(t_filters)
      filter(products, h_filter) |> filter(t_filters)
    end
    
  end # ... of OUR MODULE, George!!
