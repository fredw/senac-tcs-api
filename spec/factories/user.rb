FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password 'password'
    password_confirmation 'password'
    confirmed_at Date.today
    association :role, factory: :role_user
    customer { Customer.first || association(:customer) }

    factory :user_admin do
      association :role, factory: :role_admin
    end
  end
end