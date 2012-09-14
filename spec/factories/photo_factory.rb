FactoryGirl.define do
  sequence(:photo_identifier) {|n| "identifier #{n}" }
  sequence(:photo_description) {|n| "description #{n}" }
  factory :photo do
    thumbnail {"http://s3.freefoto.com/images/05/45/05_45_3_web.jpg"}
    full {"http://s3.freefoto.com/images/05/45/05_45_3_web.jpg"}
    photo_type {"landscape"}
  end
end
