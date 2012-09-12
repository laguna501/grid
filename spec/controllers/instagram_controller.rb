require 'spec_helper'
describe InstagramController do
  render_views

  describe "access_token_expired" do
    it "deliver extend instagram access token must sent email" do
    	user = FactoryGirl.create(:user)
    	account = FactoryGirl.create(:account, user_id: user.id, social_type: "instagram", updated_at: Time.now - 109.days)

	    get :access_token_expired
	        response.should be_success
	        ActionMailer::Base.deliveries.should be_blank	    
    end
  end
end
