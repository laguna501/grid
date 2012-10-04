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

user = User.create(
  email: "laguna501@gmail.com",
  user_type: "pro",
  nickname: "Phatthaworn"
)

FacebookAccount.create(user: user, username: "phatthaworn")
InstagramAccount.create(user: user, username: "phatthaworn")

user = User.create(
  email: "a_antarctica@hotmail.com",
  user_type: "girl",
  nickname: "Oumkwan"
)

FacebookAccount.create(user: user, username: "oumkwan")
InstagramAccount.create(user: user, username: "oumkwan")
