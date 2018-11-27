FactoryBot.define do
  factory :invoice do
    customers { nil }
    merchants { nil }
    status { "MyString" }
  end
end
