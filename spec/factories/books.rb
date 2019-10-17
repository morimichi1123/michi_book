FactoryBot.define do
  factory :book do
    sequence(:title) { |n| "title#{n}" }
    sequence(:author) { |n| "author#{n}@" }
    sequence(:publisher) { |n| "publisher#{n}" }
    sequence(:genre) { |n| "genre#{n}" }

  end
end