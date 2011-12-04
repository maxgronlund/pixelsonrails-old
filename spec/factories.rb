require 'factory_girl'

FactoryGirl.define do
  factory :user do
    name 'Test User'
    email 'user@test.com'
    password 'secret'
  end

  # Create an Admin User
  factory :admin, :class => User do
    name 'Test Admin User'
    email 'admin@test.com'
    password 'secret'
    role 'admin'
  end

  # Create a Super User
  factory :super, :class => User do |u|
    name 'Test Super User'
    email 'super@test.com'
    password 'secret'
    role 'super'
  end
end
