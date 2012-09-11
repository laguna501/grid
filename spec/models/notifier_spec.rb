require 'spec_helper'
describe Notifier do
  describe "extend_facebook_access_token" do
    it "extend facebook access token" do
      user = FactoryGirl.create(:user)
      account = FactoryGirl.create(:account, user: user)

      Notifier.extend_facebook_access_token(user).deliver

      email = ActionMailer::Base.deliveries.first
      email.from.should == [Rails.configuration.notifier_from_field]
      email.to.should == [user.email]
      email.subject.should == "Extend facebook access token"
      email.decoded.should include("get_access_token_facebook")
    end
  end

  describe "extend_instagram_access_token" do
    it "extend instagram access token" do
      user = FactoryGirl.create(:user)
      account = FactoryGirl.create(:account, user: user)

      Notifier.extend_instagram_access_token(user).deliver

      email = ActionMailer::Base.deliveries.first
      email.from.should == [Rails.configuration.notifier_from_field]
      email.to.should == [user.email]
      email.subject.should == "Extend instagram access token"
      email.decoded.should include("get_access_token_instagram")
    end
  end
end
