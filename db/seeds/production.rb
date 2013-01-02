Admin.create(
  username: "moderator",
  password: "DF9uxm58YngkohT3mTiQ",
  password_confirmation: "DF9uxm58YngkohT3mTiQ"
)

Admin.create(
  username: "arthith",
  password: "539db87c76e35754",
  password_confirmation: "539db87c76e35754"
)

Admin.create(
  username: "phatthaworn",
  password: "WDA6ZtrpDBiGi8bxkcTt",
  password_confirmation: "WDA6ZtrpDBiGi8bxkcTt"
)

user = User.new
user.email = "laguna501@gmail.com"
user.user_type = "girl"
user.nickname = "Phatthaworn"
user.full_name = "Phatthaworn Phongphaew"
user.save!

account = FacebookAccount.new
account.user = user
account.username = "phatthaworn"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "phatthaworn"
account.save!

user = User.new
user.email = "a_antarctica@hotmail.com"
user.user_type = "girl"
user.nickname = "Oumkwan"
user.full_name = "Oumkwan Puksri"
user.save!

account = FacebookAccount.new
account.user = user
account.username = "oumkwan"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "oumkwan"
account.save!

user = User.new
user.email = "heyguyiloveu@gmail.com"
user.user_type = "girl"
user.nickname = "Nok"
user.full_name = "Anchawee Leeprasert"
user.save!

account = FacebookAccount.new
account.user = user
account.username = "noknoknok.nok"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "nok_anchawee14"
account.save!

user = User.new
user.email = "loverphoenix@hotmail.com"
user.user_type = "girl"
user.nickname = "Smile"
user.full_name = "Piyaon Sitthibunyapat"
user.save!

account = FacebookAccount.new
account.user = user
account.username = "cheezysmily"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "sassysmily"
account.save!

user = User.new
user.email = "musub_69@hotmail.com"
user.user_type = "girl"
user.nickname = "Pang"
user.full_name = "Wilasinee Tiacharoen"
user.save!

account = FacebookAccount.new
account.user = user
account.username = "pang.wilasinee.3"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "pang_goh"
account.save!

user = User.new
user.email = "moonlight.eyes@hotmail.com"
user.user_type = "girl"
user.nickname = "Pou"
user.full_name = "Thanunkan Somsup"
user.save!

account = FacebookAccount.new
account.user = user
account.username = "moonangel.pou"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "thanunkan"
account.save!