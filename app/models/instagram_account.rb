class InstagramAccount < Account
  after_create :extend_access_token
  
  def extend_access_token
    Notifier.extend_instagram_access_token(self).deliver
  end
  private :extend_access_token
end
