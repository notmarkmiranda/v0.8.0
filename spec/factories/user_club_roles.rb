FactoryBot.define do
  factory :user_club_role do
    user
    club

    trait :member do
      role 0
    end

    trait :admin do
      role 1
    end
  end
end
