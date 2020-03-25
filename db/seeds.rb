# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Article.create([
  {title: "Star Wars 4", content: "A new hope", slug: "a-new-hope"},
  {title: "Star Wars 5", content: "Revenge of the Sith", slug: "revenge-of-the-sith"},
  {title: "Star Wars 6", content: "Return of the jedi", slug: "return-of-the-jedi"}

  ])
