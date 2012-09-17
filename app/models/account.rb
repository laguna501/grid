class Account < ActiveRecord::Base
  belongs_to :user, inverse_of: :accounts
  has_many :photos

  def social_type
    self.class.to_s.gsub("Account", "").downcase
  end
end
