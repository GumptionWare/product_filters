defmodule ProductFiltersTest do
  use ExUnit.Case
  doctest ProductFilters

  @products [
    %{name: "Laptop", category: :tech, price: 100_000},
    %{name: "Phone", category: :tech, price: 50000},
    %{name: "Chocolate", category: :snacks, price: 200},
    %{name: "Shampoo", category: :health, price: 1000}
  ]

  test "filter/2 empty filters" do
    # INPUT product list & no filters
    # OUTPUT the same product list
    assert ProductFilters.filter(@products, []) == @products
  end

  # @tag :skip
  test "filter/2 by exact matching name" do
    assert ProductFilters.filter(@products, name: "Laptop") ==
             [%{name: "Laptop", category: :tech, price: 100_000}]

    assert ProductFilters.filter(@products, name: "Phone") ==
             [%{name: "Phone", category: :tech, price: 50000}]
  end

  # @tag :skip
  test "filter/2 by partial matching name" do
    assert ProductFilters.filter(@products, name: "apt") ==
             [%{name: "Laptop", category: :tech, price: 100_000}]

    assert ProductFilters.filter(@products, name: "ho") ==
             [
               %{name: "Phone", category: :tech, price: 50000},
               %{name: "Chocolate", category: :snacks, price: 200}
             ]
  end

  # @tag :skip
  test "filter/2 by mixed case partial matching name" do
    assert ProductFilters.filter(@products, name: "L") ==
             [
               %{name: "Laptop", category: :tech, price: 100_000},
               %{name: "Chocolate", category: :snacks, price: 200}
             ]

    assert ProductFilters.filter(@products, name: "p") ==
             [
               %{name: "Laptop", category: :tech, price: 100_000},
               %{name: "Phone", category: :tech, price: 50000},
               %{name: "Shampoo", category: :health, price: 1000}
             ]
  end

  test "filter/2 by category" do
    assert ProductFilters.filter(@products, category: :tech) ==
             [
               %{name: "Laptop", category: :tech, price: 100_000},
               %{name: "Phone", category: :tech, price: 50000}
             ]

    assert ProductFilters.filter(@products, category: :snacks) ==
             [
               %{name: "Chocolate", category: :snacks, price: 200}
             ]

    assert ProductFilters.filter(@products, category: :snacks) == [
             %{name: "Chocolate", category: :snacks, price: 200}
           ]
  end

  test "filter/2 by min price" do
    assert ProductFilters.filter(@products, min: 5000) == [
             %{name: "Laptop", category: :tech, price: 100_000},
             %{name: "Phone", category: :tech, price: 50000}
           ]

    assert ProductFilters.filter(@products, min: 200) == [
             %{name: "Laptop", category: :tech, price: 100_000},
             %{name: "Phone", category: :tech, price: 50000},
             %{name: "Chocolate", category: :snacks, price: 200},
             %{name: "Shampoo", category: :health, price: 1000}
           ]
  end

  # @tag :skip
  test "filter/2 by max price" do
    assert ProductFilters.filter(@products, max: 50000) == [
             %{name: "Phone", category: :tech, price: 50000},
             %{name: "Chocolate", category: :snacks, price: 200},
             %{name: "Shampoo", category: :health, price: 1000}
           ]

    assert ProductFilters.filter(@products, max: 1000) == [
             %{name: "Chocolate", category: :snacks, price: 200},
             %{name: "Shampoo", category: :health, price: 1000}
           ]
  end

  # @tag :skip
  test "filter/2 by max and min price" do
    assert Enum.sort(ProductFilters.filter(@products, min: 199, max: 51000), :asc) ==
      Enum.sort([
      %{name: "Chocolate", category: :snacks, price: 200},
      %{name: "Phone", category: :tech, price: 50000},
      %{name: "Shampoo", category: :health, price: 1000}
    ], :asc)

  end

  # test "filter/2 all filters"
end
