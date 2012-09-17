FactoryGirl.define do
  sequence(:photo_identifier) {|n| "identifier #{n}" }
  sequence(:photo_description) {|n| "description #{n}" }
  factory :photo do
    thumbnail {"/assets/rails.png"}
   	full {"/assets/rails.png"}
    photo_type {"landscape"}
  end
end
