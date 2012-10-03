require 'spec_helper'
describe PhotosController do
  render_views

  before(:each) do
    request.env["HTTP_REFERER"] = photos_url
  end

  describe "index" do
    it "renders photo index form" do
      login_as do |admin, user_session|
        get :index

        assigns[:photos].should_not be_nil
        response.should be_success
        response.should render_template("index")
      end
    end
  end

  describe "change_status" do
    it "admin can set photo status to deleted" do
    	photo_1 = FactoryGirl.create(:photo)
    	photo_2 = FactoryGirl.create(:photo, deleted: true)

      login_as do |admin, user_session|
        post :change_status, select: [photo_1.identifier, photo_2.identifier], commit: "Delete Photos"

        Photo.first.deleted.should == true
        Photo.last.deleted.should == true
       	response.should redirect_to photos_url
       	flash[:notice].should include("Update photos successfully.")
      end
    end

    it "admin can set photo status to undelete" do
      photo_1 = FactoryGirl.create(:photo)
      photo_2 = FactoryGirl.create(:photo, deleted: true)

      login_as do |admin, user_session|
        post :change_status, select: [photo_1.identifier, photo_2.identifier], commit: "Undelete Photos"

        Photo.first.deleted.should == false
        Photo.last.deleted.should == false
        response.should redirect_to(:back)
        flash[:notice].should include("Update photos successfully.")
      end
    end
  end
end