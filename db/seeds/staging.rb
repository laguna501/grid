Account.where(social_type: "facebook").update_all(type: "FacebookAccount")
Account.where(social_type: "instagram").update_all(type: "InstagramAccount")