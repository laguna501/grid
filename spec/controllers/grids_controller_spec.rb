require 'spec_helper'
describe GridsController do
  render_views

  describe "index" do
    it "get index" do
    	get :index

    	response.should render_template("index")
    end
  end

  describe "show users" do
    it "query Pro user list" do
    	pro_1 = FactoryGirl.create(:account)
    	pro_2 = FactoryGirl.create(:account)
      photo_1 = FactoryGirl.create(:photo, account: pro_1)
      photo_2 = FactoryGirl.create(:photo, account: pro_2)

    	get :show_users, type: "pro"
      assigns[:user_photos][pro_1.user.nickname].should include(photo_1)
    	assigns[:user_photos][pro_2.user.nickname].should include(photo_2)
    	response.should render_template("show_users")
    end

    it "filter photos where deleted is false" do
      pro = FactoryGirl.create(:account)
      photo_1 = FactoryGirl.create(:photo, account: pro)
      photo_2 = FactoryGirl.create(:photo, account: pro)
      photo_3 = FactoryGirl.create(:photo, account: pro)
      photo_4 = FactoryGirl.create(:photo, account: pro, deleted: true) #noise

      get :show_users, type: "pro"
      assigns[:user_photos][pro.user.nickname].should include(photo_1, photo_2, photo_3)
      assigns[:user_photos][pro.user.nickname].should_not include(photo_4)
      response.should render_template("show_users")
    end
  end

  describe "show photo" do
    it "query Pro user list" do
    	pro = FactoryGirl.create(:account)
    	photo = FactoryGirl.create(:photo, account: pro)

    	get :show_photo, identifier: photo.identifier, owner: pro.user.nickname

    	assigns[:photo_description].should == photo.description
    	assigns[:user_photo].should == photo.full
    	response.should render_template("show_photo")
    end
  end
end
