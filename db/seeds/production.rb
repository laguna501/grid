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
user.user_type = "pro"
user.nickname = "Phatthaworn"
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

account = FacebookAccount.new
account.user = user
account.username = "oumkwan"
account.save!

account = InstagramAccount.new
account.user = user
account.username = "oumkwan"
account.save!
