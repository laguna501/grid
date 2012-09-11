FactoryGirl.define do
  factory :user do
    email {"test@example.com"}    
    user_type {"pro"}
    nickname {"nickname"}
  end
end
