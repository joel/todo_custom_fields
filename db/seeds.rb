# frozen_string_literal: true

# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

{
  "Grocery" => [
    "Buy milk",
    "Buy eggs"
  ],
  "Home" => [
    "Clean the house",
    "Wash the dishes"
  ],
  "Personal" => [
    "Go to the gym",
    "Go to the doctor"
  ],
  "Errands" => [
    "Go to the bank"
  ],
  "Shopping" => [
    "Buy a new phone",
    "Buy a new laptop"
  ]
}.each do |todo_name, items|
  todo_list = Todo.create(name: todo_name)

  items.each do |item_name|
    todo_list.items.create(name: item_name)
  end
end
