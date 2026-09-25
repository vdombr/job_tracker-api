FactoryBot.define do
  factory :job_app do
    company { Faker::Company.name }
    position { Faker::Company.profession }
    url { Faker::Internet.url }
    hr_contact { Faker::Internet.email }
    commentary { Faker::Lorem.sentence }
    current_stage { JobApp::STAGES.sample }
    applied_at { Faker::Date.backward(days: 30) }
  end
end
