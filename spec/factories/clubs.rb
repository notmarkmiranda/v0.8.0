FactoryBot.define do
  factory :club do
    sequence :name { |n| "Club Number #{n}" }
    sequence :slug { |n| "club-number-#{n}" }
    creator
  end
end
