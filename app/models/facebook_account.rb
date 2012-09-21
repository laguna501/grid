class FacebookAccount < Account
  after_create :extend_access_token

  def extend_access_token
    Notifier.extend_facebook_access_token(self).deliver
  end
end
