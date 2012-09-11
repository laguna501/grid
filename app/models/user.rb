class User < ActiveRecord::Base
  has_many :accounts

  def deliver_extend_facebook_access_token
    reset_perishable_token!
    Notifier.extend_facebook_access_token(self).deliver
  end

  def deliver_extend_instagram_access_token
    reset_perishable_token!
    Notifier.extend_instagram_access_token(self).deliver
  end
end
