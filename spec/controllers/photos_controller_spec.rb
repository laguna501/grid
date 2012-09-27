require 'spec_helper'
describe PhotosController do
  render_views

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
    it "admin can revert photo status" do
    	photo_1 = FactoryGirl.create(:photo)
    	photo_2 = FactoryGirl.create(:photo, deleted: true)

      login_as do |admin, user_session|
        post :change_status, select: [photo_1.identifier, photo_2.identifier]

        Photo.first.deleted.should == true
        Photo.last.deleted.should == false
       	response.should redirect_to(photos_url)
       	flash[:notice].should include("Update photos successfully.")
      end
    end
  end
end