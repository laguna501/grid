FactoryGirl.define do
  factory :instagram_account do
  	user
    username {"username"}
    access_token { "AAAB7BIx11toBAGZBkDTZA4ZChV7DdUAQE8pSRTsBGdbr49Gg64opGwvVYyr62jcSEwedsnNB6RdFlZBVgCgZAAmc7zU92hD9QChFBB669WQZDZD"}
    type       { "InstagramAccount"}
  end
end
