class FacebookAccount < Account
  def extend_access_token
    Notifier.extend_facebook_access_token(self).deliver
  end
end
