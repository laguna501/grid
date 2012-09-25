FactoryGirl.define do
  sequence(:photo_identifier) {|n| "identifier #{n}" }
  sequence(:photo_description) {|n| "description #{n}" }
  factory :photo do
    identifier              { "#{FactoryGirl.generate(:photo_identifier)}"   }
    description             { "#{FactoryGirl.generate(:photo_description)}"   }
    thumbnail 				{"/assets/rails.png"}
   	full 					{"/assets/rails.png"}
    photo_type 				{"landscape"}
    deleted 				{false}
  end
end
