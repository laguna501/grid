class Account < ActiveRecord::Base
  belongs_to :user, inverse_of: :accounts
  has_many :photos
end

class InstagramAccount < Account
  def extend_access_token
    Notifier.extend_instagram_access_token(self).deliver
  end
end

class FacebookAccount < Account
  def extend_access_token
    Notifier.extend_facebook_access_token(self).deliver
  end
end