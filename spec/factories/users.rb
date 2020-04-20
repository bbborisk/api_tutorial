FactoryBot.define do
  factory :user do
    sequence(:login) { |n| "sparrow #{n}" }
    name { "Jack Sparrow" }
    url { "http://example.com" }
    avatar_url { "http://example.com/avatar" }
    provider { "github" }
  end
end
