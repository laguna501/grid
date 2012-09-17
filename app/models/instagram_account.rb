class InstagramAccount < Account
  def extend_access_token
    Notifier.extend_instagram_access_token(self).deliver
  end
end
