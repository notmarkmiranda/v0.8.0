FactoryBot.define do
  factory :user do
    sequence :email { |n| "john_doe#{n}@email.com" }
    first_name 'John'
    last_name 'Doe'
    password 'password'
  end
end
