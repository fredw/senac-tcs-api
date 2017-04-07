FactoryGirl.define do
  factory :role_admin, class: Role do
    name 'Administrator'
    symbol Role.symbols.fetch(:admin)
    # after :create do |role|
    #   create_list :user, 1, role: role
    # end
  end
  factory :role_user, class: Role do
    name 'User'
    symbol Role.symbols.fetch(:user)
    # after :create do |role|
    #   create_list :user, 10, role: role
    # end
  end
end