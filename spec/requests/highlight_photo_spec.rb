# encoding: UTF-8
require 'request_spec_helper'

describe "Highlight and Unhighlight photos", js: true do
  describe "Highlight Photos" do
    it "As an admin I want to highlight photos for I see photo large more than other photos" do
      admin = FactoryGirl.create(:admin, username: "test", password: "000000",password_confirmation: "000000")
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo,
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        highlighted: false,
        account: account
        )

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      page.find(".highlight_button").click
      page.should have_css(".highlighted")
    end
  end

  describe "Unhighlight Photos" do
    it "As an admin I want to highlight photos for I see photo large more than other photos" do
      admin = FactoryGirl.create(:admin, username: "test", password: "000000",password_confirmation: "000000")
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo,
        identifier: '1',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg",
        highlighted: true,
        account: account
        )

      visit ("/user_session/new")
      page.should have_css("#new_user_session")
      within ("#new_user_session") do
        fill_in 'user_session[username]', :with => 'test'
        fill_in 'user_session[password]', :with => '000000'
        click_button ('Login')
      end
      page.should have_css(".frame", :text => "Login successful.")
      page.find(".highlight_button").click
      page.should have_css(".unhighlight")
    end
  end
end
