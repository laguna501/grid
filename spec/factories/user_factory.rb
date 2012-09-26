FactoryGirl.define do
  sequence(:user_login)         {|n| "user_#{n}" }
  factory :user do
    nickname                		{ "#{FactoryGirl.generate(:user_login)}"   }
    email                 			{ "#{nickname}@example.com"                    }
    user_type {"pro"}
  end
end
