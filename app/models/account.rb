class Account < ActiveRecord::Base
  belongs_to :user, inverse_of: :accounts
  has_many :photos

  def deliver_extend_facebook_access_token
    Notifier.extend_facebook_access_token(self).deliver
  end

  def deliver_extend_instagram_access_token
    Notifier.extend_instagram_access_token(self).deliver
  end

  def deliver_facebook_report_to_admin
  	Notifier.facebook_report_to_admin(self).deliver
  end
end
