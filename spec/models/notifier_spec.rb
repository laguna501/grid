require 'spec_helper'
describe Notifier do
  describe "extend_facebook_access_token" do
    it "extend facebook access token" do
      user = FactoryGirl.create(:user)
      account = FactoryGirl.create(:account, user: user)

      Notifier.extend_facebook_access_token(account).deliver

      email = ActionMailer::Base.deliveries.first
      email.from.should == [Rails.configuration.notifier_from_field]
      email.to.should == [user.email]
      email.subject.should == "Request for facebook access token"
      email.cc.should == [Rails.configuration.notifier_to_admin]
      email.decoded.should include("Extend facebook access token")
    end
  end

  describe "extend_instagram_access_token" do
    it "extend instagram access token" do
      user = FactoryGirl.create(:user)
      account = FactoryGirl.create(:account, user: user)

      Notifier.extend_instagram_access_token(account).deliver

      email = ActionMailer::Base.deliveries.first
      email.from.should == [Rails.configuration.notifier_from_field]
      email.to.should == [user.email]
      email.subject.should == "Request for instagram access token"
      email.cc.should == [Rails.configuration.notifier_to_admin]
      email.decoded.should include("Extend instagram access token")
    end
  end
end
