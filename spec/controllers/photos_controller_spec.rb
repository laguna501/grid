require 'spec_helper'
describe PhotoController do
  render_views

  describe "index" do
    it "renders photo index form" do
      login_as do |user, user_session|
        get :index

        assign[:photos].should_not be_nil
        response.should be_success
        response.should render_template("index")
      end
    end
  end
end