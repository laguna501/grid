require 'spec_helper'
describe "routing" do

  describe "grids" do
    it "routes grids resources" do
      get("/").should route_to("grids#index")
    end
  end

  describe "instagram" do
    it "routes instagram resources" do
      get("/instagram").should route_to("instagram#index")
    end
  end

  describe "callback" do
    it "routes facebook callback resources" do
      get("/facebook/callback").should route_to("facebook#callback")
    end
  end

  describe "callback" do
    it "routes instagram callback resources" do
      get("/instagram/callback").should route_to("instagram#callback")
    end
  end

  describe "access_token_expired" do
    it "routes instagram access_token_expired resources" do
      get("/instagram/access_token_expired").should route_to("instagram#access_token_expired")
    end
  end  

  describe "access_token_expired" do
    it "routes facebook access_token_expired resources" do
      get("/facebook/access_token_expired").should route_to("facebook#access_token_expired")
    end
  end

  describe "facebook_send_admin_email" do
    it "routes facebook facebook_send_admin_email resources" do
      get("/facebook/facebook_send_admin_email").should route_to("facebook#facebook_send_admin_email")
    end
  end
end
