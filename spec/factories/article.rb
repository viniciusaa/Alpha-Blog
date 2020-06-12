FactoryBot.define do
	factory :article do
		title { FFaker::Name.name }
		description { FFaker::Lorem.paragraph }
    user_id { 1 }
	end
end
