FactoryBot.define do
  factory :user do
    email { FFaker::Internet.safe_email }
    password { "123456" }
  end
end
