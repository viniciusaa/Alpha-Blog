FactoryBot.define do
	factory :article do
		title { FFaker::Name.name }
		description { FFaker::Lorem.paragraph }
	end
end
