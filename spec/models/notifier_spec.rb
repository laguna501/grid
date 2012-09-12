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
      email.decoded.should include("Extend facebook access token")
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
      email.decoded.should include("Extend instagram access token")
    end
  end

  describe "facebook_report_to_admin" do
    it "deliver facebook report to admin" do
      user = FactoryGirl.create(:user)
      account = FactoryGirl.create(:account, user: user)

      Notifier.facebook_report_to_admin(user).deliver

      email = ActionMailer::Base.deliveries.first
      email.from.should == [Rails.configuration.notifier_from_field]
      email.to.should == [Rails.configuration.notifier_to_admin]
      email.subject.should == "#{user.email}'s access token was expired"
      email.decoded.should include("#{user.email}'s access token was expired")
    end
  end
end
