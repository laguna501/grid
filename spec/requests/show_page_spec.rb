# encoding: UTF-8
require 'request_spec_helper'

describe "Test show page", js: true  do
  describe "View page"  do
    it "As an user I see photo from Facebook in view page" do
      user = FactoryGirl.create(:user, email: "artiwarah@example.com",user_type: "pro", nickname: "JOE")
      account = FactoryGirl.create(:account,username: "artiwarah", type: "FacebookAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '9',
        thumbnail: "/assets/uploads/facebook/thumbnail/artiwarah/182869_3569852204790_1354565865_n.jpg",
        full: "/assets/uploads/facebook/full/artiwarah/182869_3569852204790_1354565865_n.jpg", account: account)

      visit ("/grids/show_photo?identifier=9&owner=artiwarah")
      page.should have_css("#nickname", :text => "artiwarah")
      page.should have_css("img[@alt='182869_3569852204790_1354565865_n']")
    end

    it "As an user I see photo from Instagram" do
     user = FactoryGirl.create(:user, email: "Chanisa@example.com",user_type: "girl", nickname: "FERN")
      account = FactoryGirl.create(:account,username: "fernzzzaa", type: "InstagramAccount", user: user)
      photo = FactoryGirl.create(:photo, 
        identifier: '10',
        thumbnail: "/assets/uploads/instagram/thumbnail/fernzzzaa/9f599bd6fbc911e1a44612313804e8c1_7.jpg",
        full: "/assets/uploads/instagram/full/fernzzzaa/9f599bd6fbc911e1a44612313804e8c1_6.jpg", 
        account: account
        )

      visit ("/grids/show_photo?identifier=10&owner=fernzzzaa")
      page.should have_css("#nickname", :text => "fernzzzaa")
      page.should have_css("img[@alt='9f599bd6fbc911e1a44612313804e8c1_6']")
    end
  end
end