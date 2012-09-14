class User < ActiveRecord::Base
  has_many :accounts
  after_create :request_auth_token

  def request_auth_token
    self.accounts.each do |account|
      account.extend_access_token
    end
  end
  private :request_auth_token
end
