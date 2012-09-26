require 'spec_helper'

describe UserSessionsController do
  render_views

  describe "#new" do
    it "renders login form" do
      get :new

      response.should be_success
      response.should render_template("new")
      assigns[:user_session].should_not be_nil
      assigns[:user_session].should be_new_record
    end
  end

  describe "#create" do
    it "creates a admin session with correct credential" do
      admin = FactoryGirl.create(:admin)

      post :create, user_session: {
        "username" => admin.username,
        "password" => admin.password
      }

      response.should redirect_to("/")
    end

    it "redirect to the previous action if present" do
      admin = FactoryGirl.create(:admin)
      controller.session[:return_to] = "/arbitrary_page"

      post :create, "user_session" => {
        "username" => admin.username,
        "password" => admin.password
      }

      response.should redirect_to("/arbitrary_page")
    end

    it "render login form on failure" do
      post :create, "user_session" => {
        "username" => "nobody",
        "password" => "no password"
      }
      response.should redirect_to(new_user_session_url)
      flash[:error].should == "Login fail"
    end
  end

  describe "#destroy" do
    it "destroy the user session" do
      login_as do |admin, user_session|
        delete :destroy

        response.should redirect_to(new_user_session_url)
        user_session.record.should be_blank
      end
    end
  end
end
