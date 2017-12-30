FactoryBot.define do
  factory :user, aliases: [:creator] do
    sequence :email { |n| "john_doe#{n}@email.com" }
    first_name 'John'
    last_name 'Doe'
    password 'password'
  end
end
