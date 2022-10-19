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
    def filter(products, filters \\ []) # Idiomatic way of declaring default value
    # The "more correct" default (above) would be an empty list [].

    # Deal with the JON doctrine (no filters):
    def filter(products, []) do
      products
    end

    # Refactor: use pattern-matching instead of guard:
    def filter(products, {:category, value}) do
      Enum.filter(products, fn item ->
        item.category == value
      end)
    end

    # Refactor: use pattern-matching instead of guard:
    def filter(products, {:min, value}) do
      Enum.filter(products, fn item ->
        item.price >= value
      end)
    end

    # Refactor: use pattern-matching instead of guard:
    def filter(products, {:max, value}) do
      Enum.filter(products, fn item ->
        item.price <= value
      end)
    end

    def filter(products, {:name, value}) do
      Enum.filter(products, fn item ->
        String.contains?(String.upcase(item.name), String.upcase(value))
      end)
    end

    # Ninja refactoring via Icia's brilliance, Jon's typing, and Jeff's awe:
    # Built to pass the "min and max" test, but this turns out to drive ALL the tests
    def filter(products, [h_filter | t_filters]) do
      IO.inspect(h_filter, label: "h_filter")
      IO.inspect(t_filters, label: "t_filters")
      filter(products, h_filter) |> filter(t_filters)
    end

  end # ... of OUR MODULE, George!!
