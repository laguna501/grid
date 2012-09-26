FactoryGirl.define do
  sequence(:user_username)        {|n| "user_#{n}" }
  factory :admin do
    username         			{ "#{FactoryGirl.generate(:user_username)}"}
    password      				{ "#{username}"                            }
    password_confirmation { password                                 }
    persistence_token     { Authlogic::Random.hex_token              }
    perishable_token      { Authlogic::Random.hex_token              }
  end
end
