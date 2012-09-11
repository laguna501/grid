require 'spec_helper'
describe "routing" do
  describe "manage" do
    it "routes manages resources" do
      get("/manage").should route_to("manage#index")
    end
  end

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

  describe "pull_photos_instagram" do
    it "routes pull_photos_instagram resources" do
      get("/manage/pull_photos_instagram").should route_to("manage#pull_photos_instagram")
    end
  end

  describe "connect" do
    it "routes connect resources" do
      get("/instagram/connect").should route_to("instagram#connect")
    end
  end

  describe "pull_photos" do
    it "routes pull_photos resources" do
      get("/manage/pull_photos").should route_to("manage#pull_photos")
    end
  end

  describe "get_access_token_instagram" do
    it "routes get_access_token_instagram resources" do
      get("/manage/get_access_token_instagram").should route_to("manage#get_access_token_instagram")
    end
  end

  describe "extend_access_token" do
    it "routes extend_access_token resources" do
      get("/manage/extend_access_token").should route_to("manage#extend_access_token")
    end
  end

  describe "callback" do
    it "routes callback resources" do
      get("/manage/callback").should route_to("manage#callback")
    end
  end

  describe "callback_instagram" do
    it "routes callback_instagram resources" do
      get("/instagram/callback_instagram").should route_to("instagram#callback_instagram")
    end
  end
end
