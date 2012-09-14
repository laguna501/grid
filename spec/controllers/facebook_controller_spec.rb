require 'spec_helper'
describe FacebookController do
  render_views

  # describe "access_token_expired" do
  #   it "deliver extend facebook access token must sent email" do
  #   	user = FactoryGirl.create(:user)
  #   	account = FactoryGirl.create(:account, user_id: user.id, social_type: "facebook", updated_at: Time.now - 59.days)

	 #    get :access_token_expired
	 #        response.should be_success
	 #        ActionMailer::Base.deliveries.should_not be_blank	    
  #   end

  #   it "deliver extend facebook access token must do not send email" do
  #     user = FactoryGirl.create(:user)
  #     account = FactoryGirl.create(:account, user_id: user.id, social_type: "facebook", updated_at: Time.now)

  #     get :access_token_expired
  #         response.should be_success
  #         ActionMailer::Base.deliveries.should be_blank      
  #   end
  # end

  # describe "facebook_send_admin_email" do
  #   it "deliver report of facebook access token expired to admin" do
  #     user = FactoryGirl.create(:user)
  #     account = FactoryGirl.create(:account, user_id: user.id, social_type: "facebook", updated_at: Time.now - 60.days)

  #     get :facebook_send_admin_email
  #         response.should be_success
  #         ActionMailer::Base.deliveries.should_not be_blank     
  #   end

  #   it "do not report of facebook access token expired to admin" do
  #     user = FactoryGirl.create(:user)
  #     account = FactoryGirl.create(:account, user_id: user.id, social_type: "facebook", updated_at: Time.now)

  #     get :facebook_send_admin_email
  #         response.should be_success
  #         ActionMailer::Base.deliveries.should be_blank      
  #   end
  # end
end
