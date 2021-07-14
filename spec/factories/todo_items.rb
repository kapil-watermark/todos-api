FactoryGirl.define do
  factory :todo_item do
    title { Faker::Lorem.word }
    status { "start" }
    factory :todo_item_with_tags do
      after(:create) do |todo_item|
        create(:tag, todo_item: todo_item)
      end
    end
  end
end
